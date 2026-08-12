/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_call_summary` (
  `call_summary_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `keywords` text,
  `summary` text,
  `call_session_id` bigint NOT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `failure_reason` varchar(500) DEFAULT NULL,
  `status` enum('COMPLETED','FAILED','GENERATING') NOT NULL,
  `card_candidates` text,
  PRIMARY KEY (`call_summary_id`),
  UNIQUE KEY `UK7h2qx21xbxbjjsovyof8hhsdr` (`call_session_id`),
  CONSTRAINT `FK6wqjsx135a6yrs724mhc6lm9o` FOREIGN KEY (`call_session_id`) REFERENCES `call_sessions` (`call_session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_moderation` (
  `moderation_id` bigint NOT NULL AUTO_INCREMENT,
  `detected_at` datetime(6) NOT NULL,
  `reason` text NOT NULL,
  `review_result` varchar(30) DEFAULT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `reviewer_role` varchar(30) DEFAULT NULL,
  `risk_level` varchar(30) NOT NULL,
  `risk_type` varchar(50) NOT NULL,
  `call_session_id` bigint NOT NULL,
  `reviewed_by` bigint DEFAULT NULL,
  `subtitle_id` bigint NOT NULL,
  PRIMARY KEY (`moderation_id`),
  KEY `FK8j8s414bgb9wtyva6cck4xub8` (`call_session_id`),
  KEY `FKlftkfruvabq3ifa0hb0jwrhwj` (`reviewed_by`),
  KEY `FK37kbybemn06eascv0ecy9dlyn` (`subtitle_id`),
  CONSTRAINT `FK37kbybemn06eascv0ecy9dlyn` FOREIGN KEY (`subtitle_id`) REFERENCES `ai_subtitle` (`subtitle_id`),
  CONSTRAINT `FK8j8s414bgb9wtyva6cck4xub8` FOREIGN KEY (`call_session_id`) REFERENCES `call_sessions` (`call_session_id`),
  CONSTRAINT `FKlftkfruvabq3ifa0hb0jwrhwj` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_sessions` (
  `translation_session_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `ended_at` datetime(6) DEFAULT NULL,
  `error_message` text,
  `model_name` varchar(100) DEFAULT NULL,
  `session_sequence` int NOT NULL,
  `source_language` varchar(20) NOT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `status` enum('COMPLETED','FAILED','READY','RUNNING','STOPPED') NOT NULL,
  `target_language` varchar(20) NOT NULL,
  `call_session_id` bigint NOT NULL,
  PRIMARY KEY (`translation_session_id`),
  UNIQUE KEY `uk_ai_sessions_call_sequence` (`call_session_id`,`session_sequence`),
  CONSTRAINT `FK3qa54ghogoepsjvi8w2m6q87o` FOREIGN KEY (`call_session_id`) REFERENCES `call_sessions` (`call_session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_subtitle` (
  `subtitle_id` bigint NOT NULL AUTO_INCREMENT,
  `original_lang` varchar(20) NOT NULL,
  `original_text` text NOT NULL,
  `sequence` bigint NOT NULL,
  `speaker_role` varchar(30) NOT NULL,
  `spoken_at` datetime(6) NOT NULL,
  `translated_lang` varchar(20) DEFAULT NULL,
  `translated_text` text,
  `call_session_id` bigint NOT NULL,
  `speaker_id` bigint NOT NULL,
  PRIMARY KEY (`subtitle_id`),
  UNIQUE KEY `uk_ai_subtitle_call_sequence` (`call_session_id`,`sequence`),
  KEY `FKfcgx1kxryspkop3o79fl28s1l` (`speaker_id`),
  CONSTRAINT `FK3qeokb0sye1shsjiqk52owkdc` FOREIGN KEY (`call_session_id`) REFERENCES `call_sessions` (`call_session_id`),
  CONSTRAINT `FKfcgx1kxryspkop3o79fl28s1l` FOREIGN KEY (`speaker_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=883 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_answers` (
  `application_answer_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `answer_sequence` int NOT NULL,
  `answer_text` text,
  `application_id` bigint NOT NULL,
  `application_question_id` bigint NOT NULL,
  `selected_option_id` bigint DEFAULT NULL,
  PRIMARY KEY (`application_answer_id`),
  KEY `FKp3xgkucys2gxlrtvr0uv7rl2g` (`application_id`),
  KEY `FK6uwllo1fhnre45gwc25sh53i0` (`application_question_id`),
  KEY `FKmrgqigh7bhtitck07co695cvu` (`selected_option_id`),
  CONSTRAINT `FK6uwllo1fhnre45gwc25sh53i0` FOREIGN KEY (`application_question_id`) REFERENCES `application_questions` (`application_question_id`),
  CONSTRAINT `FKmrgqigh7bhtitck07co695cvu` FOREIGN KEY (`selected_option_id`) REFERENCES `application_options` (`application_option_id`),
  CONSTRAINT `FKp3xgkucys2gxlrtvr0uv7rl2g` FOREIGN KEY (`application_id`) REFERENCES `applications` (`application_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_forms` (
  `application_form_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `form_description` text,
  `meeting_id` bigint NOT NULL,
  PRIMARY KEY (`application_form_id`),
  UNIQUE KEY `UKh6fg2hfwyx7bduiof0chonrlv` (`meeting_id`),
  CONSTRAINT `FKfnlpelky7vlh45uxplkd1ba8b` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_options` (
  `application_option_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `display_order` int NOT NULL,
  `option_text` varchar(500) NOT NULL,
  `application_question_id` bigint NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL COMMENT '선택지 논리 삭제 시각',
  PRIMARY KEY (`application_option_id`),
  KEY `FKsanl7shk4xktmx0ayn2x2ict0` (`application_question_id`),
  CONSTRAINT `FKsanl7shk4xktmx0ayn2x2ict0` FOREIGN KEY (`application_question_id`) REFERENCES `application_questions` (`application_question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_questions` (
  `application_question_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `display_order` int NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('LONG_TEXT','MULTIPLE_CHOICE','SHORT_TEXT','SINGLE_CHOICE') NOT NULL,
  `is_required` bit(1) NOT NULL,
  `application_form_id` bigint NOT NULL,
  PRIMARY KEY (`application_question_id`),
  KEY `FKfabx5yev4owdh54s5wlrkkqam` (`application_form_id`),
  CONSTRAINT `FKfabx5yev4owdh54s5wlrkkqam` FOREIGN KEY (`application_form_id`) REFERENCES `application_forms` (`application_form_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications` (
  `application_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `personal_information_consent_at` datetime(6) NOT NULL,
  `result_decided_at` datetime(6) DEFAULT NULL,
  `status` enum('NOT_SELECTED','SELECTED','SUBMITTED','WITHDRAWN') NOT NULL,
  `submitted_at` datetime(6) NOT NULL,
  `fan_id` bigint NOT NULL,
  `meeting_id` bigint NOT NULL,
  `withdrawn_at` datetime(6) DEFAULT NULL,
  `device_hash` varchar(64) DEFAULT NULL,
  `risk_reason` varchar(255) DEFAULT NULL,
  `risk_status` enum('FLAGGED','NONE') NOT NULL,
  `recording_consent_at` datetime(6) DEFAULT NULL COMMENT '녹화·보관 동의 시각. 녹화를 쓰지 않는 팬미팅은 null',
  `participation_consent_at` datetime(6) DEFAULT NULL COMMENT '팬미팅 참여 규칙 동의 시각',
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `uk_applications_meeting_fan` (`meeting_id`,`fan_id`),
  KEY `FKia5ix6lo29oxcan3x3psfj5je` (`fan_id`),
  KEY `idx_applications_meeting_device` (`meeting_id`,`device_hash`),
  CONSTRAINT `FK9yujsi309d68950o4hn40y7vm` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`),
  CONSTRAINT `FKia5ix6lo29oxcan3x3psfj5je` FOREIGN KEY (`fan_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachments` (
  `attachment_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `display_order` int NOT NULL,
  `file_size_bytes` bigint NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `original_file_name` varchar(255) NOT NULL,
  `storage_key` varchar(500) NOT NULL,
  `post_id` bigint DEFAULT NULL COMMENT '연결된 게시글. 업로드 직후와 팬미팅 커버는 NULL',
  `uploader_user_id` bigint NOT NULL,
  `attachment_type` enum('COMMUNITY','MEETING_COVER','NOTICE') NOT NULL DEFAULT 'NOTICE' COMMENT '첨부 용도. NOTICE=공지, COMMUNITY=커뮤니티 게시글, MEETING_COVER=팬미팅 커버',
  PRIMARY KEY (`attachment_id`),
  UNIQUE KEY `UK2sdcctf875knrwgkgn11tg2l4` (`storage_key`),
  KEY `FKpeivhpes6blw5rflv2ty65erl` (`post_id`),
  KEY `FKqqhvj8bameoxgoyryy2e6pjyc` (`uploader_user_id`),
  CONSTRAINT `FKpeivhpes6blw5rflv2ty65erl` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `FKqqhvj8bameoxgoyryy2e6pjyc` FOREIGN KEY (`uploader_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_sessions` (
  `call_session_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `end_reason` enum('CONNECTION_FAILED','FAN_LEFT','FORCED','INFLUENCER_LEFT','NORMAL','TIMEOUT') DEFAULT NULL,
  `ended_at` datetime(6) DEFAULT NULL,
  `ends_at` datetime(6) DEFAULT NULL,
  `fan_lang` varchar(20) NOT NULL,
  `reconnect_allowed_until` datetime(6) DEFAULT NULL,
  `room_id` varchar(255) NOT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `status` enum('ACTIVE','CONNECTING','ENDED','FAILED') NOT NULL,
  `ended_by_user_id` bigint DEFAULT NULL,
  `queue_entry_id` bigint NOT NULL,
  PRIMARY KEY (`call_session_id`),
  UNIQUE KEY `UK4y7yljk0mk4ydvdxqrhpsw8u7` (`queue_entry_id`),
  KEY `FK4fxd7jik4rrdxgf0ecr0dtl32` (`ended_by_user_id`),
  CONSTRAINT `FK4fxd7jik4rrdxgf0ecr0dtl32` FOREIGN KEY (`ended_by_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK7cnn2355w4j1q0q2ulccquh1g` FOREIGN KEY (`queue_entry_id`) REFERENCES `queue_entries` (`queue_entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_reports` (
  `comment_report_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `detail` text,
  `processed_at` datetime(6) DEFAULT NULL,
  `reason` varchar(100) NOT NULL,
  `reported_at` datetime(6) NOT NULL,
  `status` varchar(30) NOT NULL,
  `comment_id` bigint NOT NULL,
  `processed_by_user_id` bigint DEFAULT NULL,
  `reporter_user_id` bigint NOT NULL,
  PRIMARY KEY (`comment_report_id`),
  KEY `FKtha4b2s2qhg4wj6cedd1dkt4p` (`comment_id`),
  KEY `FKlnfroq0mx94hlqt5jiqfn1jhu` (`processed_by_user_id`),
  KEY `FKa826hxqvqvmqdu4o0s8uswijy` (`reporter_user_id`),
  CONSTRAINT `FKa826hxqvqvmqdu4o0s8uswijy` FOREIGN KEY (`reporter_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKlnfroq0mx94hlqt5jiqfn1jhu` FOREIGN KEY (`processed_by_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKtha4b2s2qhg4wj6cedd1dkt4p` FOREIGN KEY (`comment_id`) REFERENCES `post_comments` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_checks` (
  `device_check_id` bigint NOT NULL AUTO_INCREMENT,
  `camera_ok` bit(1) NOT NULL,
  `checked_at` datetime(6) NOT NULL,
  `microphone_ok` bit(1) NOT NULL,
  `network_ok` bit(1) NOT NULL,
  `speaker_ok` bit(1) DEFAULT NULL,
  `meeting_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`device_check_id`),
  KEY `FKoyfxiwsfixlse5073wo2ovi26` (`meeting_id`),
  KEY `FKlfbgeu39xbhve6vhxm0rnt0gf` (`user_id`),
  CONSTRAINT `FKlfbgeu39xbhve6vhxm0rnt0gf` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKoyfxiwsfixlse5073wo2ovi26` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_verification_tokens` (
  `email_verification_token_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `consumed_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `token_hash` varchar(128) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`email_verification_token_id`),
  UNIQUE KEY `UKah12jdrm74nfnmu11x9xxlbex` (`token_hash`),
  KEY `idx_email_verification_tokens_user` (`user_id`),
  CONSTRAINT `FKi1c4mmamlb8keqt74k4lrtwhc` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fan_card` (
  `fan_card_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `text` text NOT NULL,
  `call_session_id` bigint NOT NULL,
  PRIMARY KEY (`fan_card_id`),
  UNIQUE KEY `UKkost3b4d3p63lsa9je8eb3p5d` (`call_session_id`),
  CONSTRAINT `FKpq2aa9asd1plkhmeln98c7mig` FOREIGN KEY (`call_session_id`) REFERENCES `call_sessions` (`call_session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fan_meetings` (
  `meeting_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `actual_end_at` datetime(6) DEFAULT NULL,
  `actual_start_at` datetime(6) DEFAULT NULL,
  `cover_image_url` varchar(2048) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `description` text,
  `published_at` datetime(6) DEFAULT NULL,
  `scheduled_start_at` datetime(6) NOT NULL,
  `status` enum('APPLICATION_CLOSED','APPLICATION_OPEN','CANCELED','DRAFT','ENDED','LIVE','PUBLISHED','READY') NOT NULL,
  `title` varchar(200) NOT NULL,
  `influencer_id` bigint NOT NULL,
  `manager_id` bigint DEFAULT NULL,
  `organization_id` bigint DEFAULT NULL,
  `canceled_at` datetime(6) DEFAULT NULL,
  `participant_selection_type` enum('APPLICATION','EXTERNAL_SELECTION') NOT NULL,
  PRIMARY KEY (`meeting_id`),
  KEY `FKpjkgl9k3fxw7xar5bm66rh5ei` (`influencer_id`),
  KEY `FKc0d0ata6e8vgpfxxamhqyxl9f` (`manager_id`),
  KEY `FKe7eg7tt6buppwddrpmxw9fy9y` (`organization_id`),
  CONSTRAINT `FKc0d0ata6e8vgpfxxamhqyxl9f` FOREIGN KEY (`manager_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKe7eg7tt6buppwddrpmxw9fy9y` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`),
  CONSTRAINT `FKpjkgl9k3fxw7xar5bm66rh5ei` FOREIGN KEY (`influencer_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fan_memos` (
  `fan_memo_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `content` text NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `fan_id` bigint NOT NULL,
  `influencer_id` bigint NOT NULL,
  `meeting_id` bigint DEFAULT NULL,
  PRIMARY KEY (`fan_memo_id`),
  KEY `FKic730qstca4824xydr5y48ol` (`fan_id`),
  KEY `FKb14r1bok5002mqpolvblpiex0` (`influencer_id`),
  KEY `FK1gm2uev7tvhyexgjb16k31p4f` (`meeting_id`),
  CONSTRAINT `FK1gm2uev7tvhyexgjb16k31p4f` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`),
  CONSTRAINT `FKb14r1bok5002mqpolvblpiex0` FOREIGN KEY (`influencer_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKic730qstca4824xydr5y48ol` FOREIGN KEY (`fan_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `followings` (
  `following_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `followed_influencer_id` bigint NOT NULL,
  `follower_user_id` bigint NOT NULL,
  PRIMARY KEY (`following_id`),
  UNIQUE KEY `uk_followings_follower_influencer` (`follower_user_id`,`followed_influencer_id`),
  KEY `FKm4sp7a4vqk34pwhpr67sax7v7` (`followed_influencer_id`),
  CONSTRAINT `FKm4sp7a4vqk34pwhpr67sax7v7` FOREIGN KEY (`followed_influencer_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKq45e86xjkhl4oo0wx7sejww2m` FOREIGN KEY (`follower_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `influencer_profiles` (
  `influencer_profile_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `activity_name` varchar(100) NOT NULL,
  `banner_image_url` varchar(2048) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `introduction` text,
  `social_url` varchar(2048) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`influencer_profile_id`),
  UNIQUE KEY `UKqgaytnv5bt7s5gjnkg54lb2ue` (`user_id`),
  CONSTRAINT `FKap2ey8yowip926r5opnfre1n0` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting_application_settings` (
  `meeting_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `application_close_at` datetime(6) DEFAULT NULL,
  `application_open_at` datetime(6) DEFAULT NULL,
  `capacity` int NOT NULL,
  `application_enabled` bit(1) NOT NULL,
  `result_announcement_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`meeting_id`),
  CONSTRAINT `FK5doe0ghbfcyxkn77qbrr0axw6` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting_operation_settings` (
  `meeting_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `call_duration_sec` int NOT NULL,
  `recording_enabled` bit(1) NOT NULL,
  `translation_enabled` bit(1) NOT NULL,
  `waiting_room_open_at` datetime(6) DEFAULT NULL,
  `early_start_minutes` int NOT NULL DEFAULT '30',
  `max_recall_count` int NOT NULL DEFAULT '1',
  `reconnect_grace_sec` int NOT NULL DEFAULT '60',
  PRIMARY KEY (`meeting_id`),
  CONSTRAINT `FK7x8i1perdhp16uj9vqafa92gn` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `message` text NOT NULL,
  `read_at` datetime(6) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `notification_type` enum('APPLICATION_RESULT','ENTER_NOW','MEETING_CANCELED','MEETING_CHANGED','MEETING_PUBLISHED','ORGANIZATION_INVITATION_ACCEPTED','ORGANIZATION_INVITED','ORGANIZATION_MEMBER_REMOVED','QUEUE_CHANGE_RESULT','QUEUE_ORDER_ASSIGNED') NOT NULL,
  `meeting_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `message_key` varchar(80) DEFAULT NULL,
  `message_args` text,
  PRIMARY KEY (`notification_id`),
  KEY `FKlg1umpouoq23aurdwipe9h397` (`meeting_id`),
  KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`),
  CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKlg1umpouoq23aurdwipe9h397` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization_members` (
  `organization_member_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `joined_at` datetime(6) NOT NULL,
  `left_at` datetime(6) DEFAULT NULL,
  `member_type` enum('INFLUENCER','MANAGER') NOT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL,
  `organization_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`organization_member_id`),
  UNIQUE KEY `uk_organization_members_organization_user` (`organization_id`,`user_id`),
  KEY `FK67edx4b35ogkpk3ghbhwand9i` (`user_id`),
  CONSTRAINT `FK67edx4b35ogkpk3ghbhwand9i` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK7vpc2vd3jlfahlombjdc32mhe` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations` (
  `organization_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `business_number` varchar(30) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(30) DEFAULT NULL,
  `description` text,
  `logo_url` varchar(2048) DEFAULT NULL,
  `organization_name` varchar(150) NOT NULL,
  `representative_name` varchar(100) DEFAULT NULL,
  `status` varchar(30) NOT NULL,
  PRIMARY KEY (`organization_id`),
  UNIQUE KEY `UK54tanpt7pgm1ao25rat8ecd68` (`business_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participants` (
  `participant_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `assigned_order` int NOT NULL,
  `recording_consent_at` datetime(6) DEFAULT NULL,
  `status` varchar(30) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `fan_id` bigint NOT NULL,
  `meeting_id` bigint NOT NULL,
  `participant_source` enum('APPLICATION','EXTERNAL_SELECTION') NOT NULL,
  PRIMARY KEY (`participant_id`),
  UNIQUE KEY `uk_participants_meeting_fan` (`meeting_id`,`fan_id`),
  UNIQUE KEY `UKn79hjboim49l472b4a7mmk1ev` (`application_id`),
  KEY `FKl9r3lo8d7ckh754mj1l71gn2p` (`fan_id`),
  CONSTRAINT `FK15m0610ubrp3kiairatft5w9h` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`),
  CONSTRAINT `FKl9r3lo8d7ckh754mj1l71gn2p` FOREIGN KEY (`fan_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKlbs0dbssyu6er8go61k0a95db` FOREIGN KEY (`application_id`) REFERENCES `applications` (`application_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_comments` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `content` text NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `status` varchar(30) NOT NULL,
  `author_user_id` bigint NOT NULL,
  `parent_comment_id` bigint DEFAULT NULL,
  `post_id` bigint NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `FKboxownagb77sjl45e0k73jnve` (`author_user_id`),
  KEY `FK21q7y8a124im4g0l4aaxn4ol1` (`parent_comment_id`),
  KEY `FKaawaqxjs3br8dw5v90w7uu514` (`post_id`),
  CONSTRAINT `FK21q7y8a124im4g0l4aaxn4ol1` FOREIGN KEY (`parent_comment_id`) REFERENCES `post_comments` (`comment_id`),
  CONSTRAINT `FKaawaqxjs3br8dw5v90w7uu514` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `FKboxownagb77sjl45e0k73jnve` FOREIGN KEY (`author_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `content` text NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `is_pinned` bit(1) NOT NULL,
  `status` enum('DRAFT','HIDDEN','PUBLISHED') NOT NULL,
  `title` varchar(200) NOT NULL,
  `post_type` enum('COMMUNITY','MEETING_NOTICE','SERVICE_NOTICE') NOT NULL,
  `view_count` bigint NOT NULL,
  `author_user_id` bigint NOT NULL,
  `meeting_id` bigint DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `FK446gjq0cnhqile4mytd0fo2km` (`author_user_id`),
  KEY `FK7gbkwmsvgxuoaxhw8cc8h0ka1` (`meeting_id`),
  CONSTRAINT `FK446gjq0cnhqile4mytd0fo2km` FOREIGN KEY (`author_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK7gbkwmsvgxuoaxhw8cc8h0ka1` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_change_requests` (
  `queue_change_request_id` bigint NOT NULL AUTO_INCREMENT,
  `changed_queue_position` int DEFAULT NULL,
  `previous_queue_position` int DEFAULT NULL,
  `processed_at` datetime(6) DEFAULT NULL,
  `request_reason` text NOT NULL,
  `requested_at` datetime(6) NOT NULL,
  `status` enum('APPROVED','PENDING','REJECTED') NOT NULL,
  `processed_by_user_id` bigint DEFAULT NULL,
  `queue_entry_id` bigint NOT NULL,
  PRIMARY KEY (`queue_change_request_id`),
  KEY `FK3ob9h04ag4dn2tcj5pb4605c1` (`processed_by_user_id`),
  KEY `FKhdmpt6cqu0i3by6l0mfd7a1m2` (`queue_entry_id`),
  CONSTRAINT `FK3ob9h04ag4dn2tcj5pb4605c1` FOREIGN KEY (`processed_by_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKhdmpt6cqu0i3by6l0mfd7a1m2` FOREIGN KEY (`queue_entry_id`) REFERENCES `queue_entries` (`queue_entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_entries` (
  `queue_entry_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `called_at` datetime(6) DEFAULT NULL,
  `entered_at` datetime(6) DEFAULT NULL,
  `no_show_at` datetime(6) DEFAULT NULL,
  `queue_position` int NOT NULL,
  `recall_count` int NOT NULL,
  `status` enum('CALLED','DONE','IN_CALL','NOT_ENTERED','NO_SHOW','REMOVED','SKIPPED','WAITING') NOT NULL,
  `meeting_id` bigint NOT NULL,
  `participant_id` bigint NOT NULL,
  `last_change_reason` varchar(300) DEFAULT NULL,
  `last_changed_at` datetime(6) DEFAULT NULL,
  `last_change_key` varchar(80) DEFAULT NULL,
  `last_change_args` text,
  PRIMARY KEY (`queue_entry_id`),
  UNIQUE KEY `UKaojm299u97xjxrtawloju017k` (`participant_id`),
  KEY `FKfj58mn6ghr7xb10u3stjgwrbq` (`meeting_id`),
  CONSTRAINT `FKfj58mn6ghr7xb10u3stjgwrbq` FOREIGN KEY (`meeting_id`) REFERENCES `fan_meetings` (`meeting_id`),
  CONSTRAINT `FKgt6mlqajkk21oy9rbf32nlm4l` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`participant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recordings` (
  `recording_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `available_until` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `content_type` varchar(100) NOT NULL,
  `duration_sec` int DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_size_bytes` bigint DEFAULT NULL,
  `retry_count` int NOT NULL,
  `status` enum('AVAILABLE','DELETED','EXPIRED','FAILED','PROCESSING','RECORDING','STARTING') NOT NULL,
  `storage_key` varchar(500) NOT NULL,
  `call_session_id` bigint NOT NULL,
  `egress_ended_at` datetime(6) DEFAULT NULL,
  `egress_id` varchar(128) DEFAULT NULL,
  `egress_started_at` datetime(6) DEFAULT NULL,
  `failure_code` varchar(100) DEFAULT NULL,
  `failure_message` varchar(1000) DEFAULT NULL,
  `requested_at` datetime(6) DEFAULT NULL,
  `room_name` varchar(255) DEFAULT NULL,
  `source` varchar(30) NOT NULL DEFAULT 'BROWSER_UPLOAD',
  PRIMARY KEY (`recording_id`),
  UNIQUE KEY `UKgabc4h5c4uvcg55v1fv7muhdl` (`storage_key`),
  UNIQUE KEY `UKqspnq3pb2t43kv0sr3mrpiw3s` (`call_session_id`),
  UNIQUE KEY `UKog1d9wa61k0ochpg0osecpov8` (`egress_id`),
  KEY `idx_recordings_status_updated_at` (`status`,`updated_at`),
  CONSTRAINT `FKdwj5kf4gsx3t286o8k91rmey2` FOREIGN KEY (`call_session_id`) REFERENCES `call_sessions` (`call_session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_accounts` (
  `social_account_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `provider` enum('GOOGLE','KAKAO','NAVER') NOT NULL,
  `provider_user_id` varchar(255) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`social_account_id`),
  UNIQUE KEY `uk_social_accounts_provider_user` (`provider`,`provider_user_id`),
  UNIQUE KEY `uk_social_accounts_user_provider` (`user_id`,`provider`),
  CONSTRAINT `FK6rmxxiton5yuvu7ph2hcq2xn7` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `email` varchar(255) NOT NULL,
  `last_login_at` datetime(6) DEFAULT NULL,
  `login_id` varchar(100) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `preferred_language` enum('ENGLISH','KOREAN') NOT NULL,
  `profile_image_url` varchar(2048) DEFAULT NULL,
  `role` enum('ADMIN','FAN','INFLUENCER','MANAGER','SOLO_INFLUENCER') NOT NULL,
  `status` enum('ACTIVE','SUSPENDED','WITHDRAWN') NOT NULL,
  `withdrawn_at` datetime(6) DEFAULT NULL,
  `email_verified_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  UNIQUE KEY `UKi3xs7wmfu2i3jt079uuetycit` (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
