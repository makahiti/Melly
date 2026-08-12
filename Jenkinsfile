pipeline {
    agent any

    environment {
        PROJECT_DIR    = '/home/ubuntu/docker/project'
        SOURCE_DIR     = '/home/ubuntu/docker/project/S15P11E106'
        GIT_REPOSITORY = 'https://lab.ssafy.com/s15-webmobile1-sub1/S15P11E106.git'
        GIT_BRANCH     = 'lab'
        COMPOSE_FILE   = '/home/ubuntu/docker/project/S15P11E106/infra/prod/docker-compose.prod.yml'
        ENV_FILE       = '/home/ubuntu/docker/project/.env'
    }

    options {
        disableConcurrentBuilds()
        timestamps()
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {
        stage('Check Environment') {
            steps {
                sh '''
                    set -eu

                    echo "=== Environment Check ==="

                    docker --version
                    docker compose version
                    git --version

                    git config --global --add safe.directory "$SOURCE_DIR"

                    test -d "$SOURCE_DIR/.git"
                    test -f "$ENV_FILE"
                    test -f "$COMPOSE_FILE"
                    test -f "$SOURCE_DIR/infra/prod/scripts/deploy.sh"

                    docker compose \
                      -p project \
                      --env-file "$ENV_FILE" \
                      -f "$COMPOSE_FILE" \
                      config --quiet

                    echo "Environment check completed"
                '''
            }
        }

        stage('Update Source') {
            steps {
                dir("${SOURCE_DIR}") {
                    withCredentials([
                        usernamePassword(
                            credentialsId: 'ssafy-gitlab',
                            usernameVariable: 'GIT_USERNAME',
                            passwordVariable: 'GIT_TOKEN'
                        )
                    ]) {
                        sh '''
                            set -eu

                            echo "=== Update Source ==="
                            echo "Target branch: $GIT_BRANCH"

                            AUTH_REPOSITORY="https://${GIT_USERNAME}:${GIT_TOKEN}@lab.ssafy.com/s15-webmobile1-sub1/S15P11E106.git"

                            git fetch --prune "$AUTH_REPOSITORY" "$GIT_BRANCH"
                            git reset --hard FETCH_HEAD
                            git clean -fd

                            unset AUTH_REPOSITORY

                            echo "Current branch:"
                            git branch --show-current

                            echo "Current commit:"
                            git log -1 --oneline
                        '''
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                dir("${SOURCE_DIR}") {
                    sh '''
                        set -eu

                        echo "=== Production Deploy ==="

                        bash ./infra/prod/scripts/deploy.sh
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    set -eu

                    echo "=== Verify Deployment ==="

                    docker compose \
                      -p project \
                      --env-file "$ENV_FILE" \
                      -f "$COMPOSE_FILE" \
                      ps

                    test "$(docker inspect -f '{{.State.Running}}' mysql)" = "true"
                    test "$(docker inspect -f '{{.State.Running}}' redis)" = "true"
                    test "$(docker inspect -f '{{.State.Running}}' livekit)" = "true"
                    test "$(docker inspect -f '{{.State.Running}}' backend)" = "true"
                    test "$(docker inspect -f '{{.State.Running}}' frontend)" = "true"
                    test "$(docker inspect -f '{{.State.Running}}' nginx)" = "true"

                    echo "Waiting for HTTPS service..."

                    attempt=1
                    while [ "$attempt" -le 12 ]; do
                        HTTP_CODE=$(curl -ksS -o /dev/null -w '%{http_code}' \
                          https://i15e106.p.ssafy.io || true)

                        if [ "$HTTP_CODE" = "200" ]; then
                            echo "Frontend health check succeeded: HTTP $HTTP_CODE"
                            exit 0
                        fi

                        echo "Attempt $attempt/12: HTTP $HTTP_CODE"
                        sleep 5
                        attempt=$((attempt + 1))
                    done

                    echo "Frontend health check failed"
                    exit 1
                '''
            }
        }
    }

    post {
        success {
            echo 'Melly production deployment succeeded.'
        }

        failure {
            echo 'Melly production deployment failed. Check the Jenkins Console Output.'
        }

        always {
            sh '''
                echo "=== Final Container Status ==="

                docker compose \
                  -p project \
                  --env-file "$ENV_FILE" \
                  -f "$COMPOSE_FILE" \
                  ps || true

                echo "=== Current Git Commit ==="

                git -C "$SOURCE_DIR" log -1 --oneline || true
            '''
        }
    }
}
