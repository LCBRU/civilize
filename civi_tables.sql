DROP TABLE IF EXISTS `2015Q4_CRN_Reimbursements`;
CREATE TABLE `2015Q4_CRN_Reimbursements` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `2015Q4_Practice_Reimbursement_excluded`;
CREATE TABLE `2015Q4_Practice_Reimbursement_excluded` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `2015Q4_Practice_Reimbursement_withdrawn`;
CREATE TABLE `2015Q4_Practice_Reimbursement_withdrawn` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `20160801_GenvascPostCodes`;
CREATE TABLE `20160801_GenvascPostCodes` (
  `GptNumber` varchar(250) DEFAULT NULL,
  `Postcode` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `2016Q1_2015Q4_DIFF_CRN_Reimbursements`;
CREATE TABLE `2016Q1_2015Q4_DIFF_CRN_Reimbursements` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `2016Q1_CRN_Reimbursements`;
CREATE TABLE `2016Q1_CRN_Reimbursements` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `2016Q1_Practice_Reimbursement_excluded`;
CREATE TABLE `2016Q1_Practice_Reimbursement_excluded` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `2016Q1_Practice_Reimbursement_withdrawn`;
CREATE TABLE `2016Q1_Practice_Reimbursement_withdrawn` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `2016Q1__2015Q4_DIFF_Practice_Reimbursement_excluded`;
CREATE TABLE `2016Q1__2015Q4_DIFF_Practice_Reimbursement_excluded` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `2016Q1__2015Q4_DIFF_Practice_Reimbursement_withdrawn`;
CREATE TABLE `2016Q1__2015Q4_DIFF_Practice_Reimbursement_withdrawn` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `2016Q4_Manual_ExcludedWithdrawn`;
CREATE TABLE `2016Q4_Manual_ExcludedWithdrawn` (
  `GptNumber` varchar(250) DEFAULT NULL
);

DROP TABLE IF EXISTS `civicrm_acl`;
CREATE TABLE `civicrm_acl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'ACL Name.',
  `deny` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Is this ACL entry Allow  (0) or Deny (1) ?',
  `entity_table` varchar(64) NOT NULL COMMENT 'Table of the object possessing this ACL entry (Contact, Group, or ACL Group)',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the object possessing this ACL',
  `operation` varchar(8) NOT NULL COMMENT 'What operation does this ACL entry control?',
  `object_table` varchar(64) DEFAULT NULL COMMENT 'The table of the object controlled by this ACL entry',
  `object_id` int(10) unsigned DEFAULT NULL COMMENT 'The ID of the object controlled by this ACL entry',
  `acl_table` varchar(64) DEFAULT NULL COMMENT 'If this is a grant/revoke entry, what table are we granting?',
  `acl_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the ACL or ACL group being granted/revoked',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  PRIMARY KEY (`id`),
  KEY `index_acl_id` (`acl_id`)
);

DROP TABLE IF EXISTS `civicrm_acl_cache`;
CREATE TABLE `civicrm_acl_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign Key to Contact',
  `acl_id` int(10) unsigned NOT NULL COMMENT 'Foreign Key to ACL',
  `modified_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_acl_id` (`acl_id`),
  KEY `FK_civicrm_acl_cache_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_acl_contact_cache`;
CREATE TABLE `civicrm_acl_contact_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact (could be null for anon user)',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contact',
  `operation` varchar(8) NOT NULL COMMENT 'What operation does this user have permission on?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_user_contact_operation` (`user_id`,`contact_id`,`operation`),
  KEY `FK_civicrm_acl_contact_cache_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_acl_entity_role`;
CREATE TABLE `civicrm_acl_entity_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `acl_role_id` int(10) unsigned NOT NULL COMMENT 'Foreign Key to ACL Role (which is an option value pair and hence an implicit FK)',
  `entity_table` varchar(64) NOT NULL COMMENT 'Table of the object joined to the ACL Role (Contact or Group)',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'ID of the group/contact object being joined',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  PRIMARY KEY (`id`),
  KEY `index_role` (`acl_role_id`),
  KEY `index_entity` (`entity_table`,`entity_id`)
);

DROP TABLE IF EXISTS `civicrm_action_log`;
CREATE TABLE `civicrm_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to id of the entity that the action was performed on. Pseudo - FK.',
  `entity_table` varchar(255) DEFAULT NULL COMMENT 'name of the entity table for the above id, e.g. civicrm_activity, civicrm_participant',
  `action_schedule_id` int(10) unsigned NOT NULL COMMENT 'FK to the action schedule that this action originated from.',
  `action_date_time` datetime DEFAULT NULL COMMENT 'date time that the action was performed on.',
  `is_error` tinyint(4) DEFAULT 0 COMMENT 'Was there any error sending the reminder?',
  `message` text DEFAULT NULL COMMENT 'Description / text in case there was an error encountered.',
  `repetition_number` int(10) unsigned DEFAULT NULL COMMENT 'Keeps track of the sequence number of this repetition.',
  `reference_date` date DEFAULT NULL COMMENT 'Stores the date from the entity which triggered this reminder action (e.g. membership.end_date for most membership renewal reminders)',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_action_log_contact_id` (`contact_id`),
  KEY `FK_civicrm_action_log_action_schedule_id` (`action_schedule_id`)
);

DROP TABLE IF EXISTS `civicrm_action_mapping`;
CREATE TABLE `civicrm_action_mapping` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity` varchar(64) DEFAULT NULL COMMENT 'Entity for which the reminder is created',
  `entity_value` varchar(64) DEFAULT NULL COMMENT 'Entity value',
  `entity_value_label` varchar(64) DEFAULT NULL COMMENT 'Entity value label',
  `entity_status` varchar(64) DEFAULT NULL COMMENT 'Entity status',
  `entity_status_label` varchar(64) DEFAULT NULL COMMENT 'Entity status label',
  `entity_date_start` varchar(64) DEFAULT NULL COMMENT 'Entity date',
  `entity_date_end` varchar(64) DEFAULT NULL COMMENT 'Entity date',
  `entity_recipient` varchar(64) DEFAULT NULL COMMENT 'Entity recipient',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_action_schedule`;
CREATE TABLE `civicrm_action_schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT 'Name of the action(reminder)',
  `title` varchar(64) DEFAULT NULL COMMENT 'Title of the action(reminder)',
  `recipient` varchar(64) DEFAULT NULL COMMENT 'Recipient',
  `limit_to` tinyint(4) DEFAULT NULL,
  `entity_value` varchar(255) DEFAULT NULL COMMENT 'Entity value',
  `entity_status` varchar(64) DEFAULT NULL COMMENT 'Entity status',
  `start_action_offset` int(10) unsigned DEFAULT NULL COMMENT 'Reminder Interval.',
  `start_action_unit` varchar(8) DEFAULT NULL COMMENT 'Time units for reminder.',
  `start_action_condition` varchar(64) DEFAULT NULL COMMENT 'Reminder Action',
  `start_action_date` varchar(64) DEFAULT NULL COMMENT 'Entity date',
  `is_repeat` tinyint(4) DEFAULT 0,
  `repetition_frequency_unit` varchar(8) DEFAULT NULL COMMENT 'Time units for repetition of reminder.',
  `repetition_frequency_interval` int(10) unsigned DEFAULT NULL COMMENT 'Time interval for repeating the reminder.',
  `end_frequency_unit` varchar(8) DEFAULT NULL COMMENT 'Time units till repetition of reminder.',
  `end_frequency_interval` int(10) unsigned DEFAULT NULL COMMENT 'Time interval till repeating the reminder.',
  `end_action` varchar(32) DEFAULT NULL COMMENT 'Reminder Action till repeating the reminder.',
  `end_date` varchar(64) DEFAULT NULL COMMENT 'Entity end date',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this option active?',
  `recipient_manual` varchar(128) DEFAULT NULL COMMENT 'Contact IDs to which reminder should be sent.',
  `recipient_listing` varchar(128) DEFAULT NULL COMMENT 'listing based on recipient field.',
  `body_text` longtext DEFAULT NULL COMMENT 'Body of the mailing in text format.',
  `body_html` longtext DEFAULT NULL COMMENT 'Body of the mailing in html format.',
  `sms_body_text` longtext DEFAULT NULL COMMENT 'Body of the mailing in html format.',
  `subject` varchar(128) DEFAULT NULL COMMENT 'Subject of mailing',
  `record_activity` tinyint(4) DEFAULT NULL COMMENT 'Record Activity for this reminder?',
  `mapping_id` varchar(64) DEFAULT NULL,
  `group_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Group',
  `msg_template_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the message template.',
  `sms_template_id` int(10) unsigned DEFAULT NULL COMMENT 'SMS Reminder Template. FK to id in civicrm_msg_template.',
  `absolute_date` date DEFAULT NULL COMMENT 'Date on which the reminder be sent.',
  `from_name` varchar(255) DEFAULT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  `mode` varchar(128) DEFAULT 'Email' COMMENT 'Send the message as email or sms or both.',
  `sms_provider_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_sms_provider id ',
  `used_for` varchar(64) DEFAULT NULL COMMENT 'Used for repeating entity',
  `filter_contact_language` varchar(128) DEFAULT NULL COMMENT 'Used for multilingual installation',
  `communication_language` varchar(8) DEFAULT NULL COMMENT 'Used for multilingual installation',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_action_schedule_mapping_id` (`mapping_id`),
  KEY `FK_civicrm_action_schedule_group_id` (`group_id`),
  KEY `FK_civicrm_action_schedule_msg_template_id` (`msg_template_id`),
  KEY `FK_civicrm_action_schedule_sms_provider_id` (`sms_provider_id`),
  KEY `FK_civicrm_action_schedule_sms_template_id` (`sms_template_id`)
);

DROP TABLE IF EXISTS `civicrm_activity`;
CREATE TABLE `civicrm_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique  Other Activity ID',
  `source_record_id` int(10) unsigned DEFAULT NULL COMMENT 'Artificial FK to original transaction (e.g. contribution) IF it is not an Activity. Table can be figured out through activity_type_id, and further through component registry.',
  `activity_type_id` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'FK to civicrm_option_value.id, that has to be valid, registered activity type.',
  `subject` varchar(255) DEFAULT NULL COMMENT 'The subject/purpose/short description of the activity.',
  `activity_date_time` datetime DEFAULT NULL COMMENT 'Date and time this activity is scheduled to occur. Formerly named scheduled_date_time.',
  `duration` int(10) unsigned DEFAULT NULL COMMENT 'Planned or actual duration of activity expressed in minutes. Conglomerate of former duration_hours and duration_minutes.',
  `location` varchar(255) DEFAULT NULL COMMENT 'Location of the activity (optional, open text).',
  `phone_id` int(10) unsigned DEFAULT NULL COMMENT 'Phone ID of the number called (optional - used if an existing phone number is selected).',
  `phone_number` varchar(64) DEFAULT NULL COMMENT 'Phone number in case the number does not exist in the civicrm_phone table.',
  `details` longtext DEFAULT NULL COMMENT 'Details about the activity (agenda, notes, etc).',
  `status_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the status this activity is currently in. Foreign key to civicrm_option_value.',
  `priority_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the priority given to this activity. Foreign key to civicrm_option_value.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent meeting ID (if this is a follow-up item). This is not currently implemented',
  `is_test` tinyint(4) DEFAULT 0,
  `medium_id` int(10) unsigned DEFAULT NULL COMMENT 'Activity Medium, Implicit FK to civicrm_option_value where option_group = encounter_medium.',
  `is_auto` tinyint(4) DEFAULT 0,
  `relationship_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Relationship ID',
  `is_current_revision` tinyint(4) DEFAULT 1,
  `original_id` int(10) unsigned DEFAULT NULL COMMENT 'Activity ID of the first activity record in versioning chain.',
  `result` varchar(255) DEFAULT NULL COMMENT 'Currently being used to store result id for survey activity, FK to option value.',
  `is_deleted` tinyint(4) DEFAULT 0,
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'The campaign for which this activity has been triggered.',
  `engagement_level` int(10) unsigned DEFAULT NULL COMMENT 'Assign a specific level of engagement to this activity. Used for tracking constituents in ladder of engagement.',
  `weight` int(11) DEFAULT NULL,
  `is_star` tinyint(4) DEFAULT 0 COMMENT 'Activity marked as favorite.',
  PRIMARY KEY (`id`),
  KEY `UI_source_record_id` (`source_record_id`),
  KEY `UI_activity_type_id` (`activity_type_id`),
  KEY `index_medium_id` (`medium_id`),
  KEY `index_is_current_revision` (`is_current_revision`),
  KEY `index_is_deleted` (`is_deleted`),
  KEY `FK_civicrm_activity_phone_id` (`phone_id`),
  KEY `FK_civicrm_activity_parent_id` (`parent_id`),
  KEY `FK_civicrm_activity_relationship_id` (`relationship_id`),
  KEY `FK_civicrm_activity_original_id` (`original_id`),
  KEY `FK_civicrm_activity_campaign_id` (`campaign_id`),
  KEY `civicrm_activity_is_deleted_IDX` (`is_deleted`,`activity_type_id`) USING BTREE
);

DROP TABLE IF EXISTS `civicrm_activity_contact`;
CREATE TABLE `civicrm_activity_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Activity contact id',
  `activity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the activity for this record.',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the contact for this record.',
  `record_type_id` int(10) unsigned DEFAULT NULL COMMENT 'The record type id for this row',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_activity_contact` (`contact_id`,`activity_id`,`record_type_id`),
  KEY `FK_civicrm_activity_contact_activity_id` (`activity_id`),
  KEY `index_record_type` (`activity_id`,`record_type_id`)
);

DROP TABLE IF EXISTS `civicrm_address`;
CREATE TABLE `civicrm_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Address ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this address belong to.',
  `is_primary` tinyint(4) DEFAULT 0 COMMENT 'Is this the primary address.',
  `is_billing` tinyint(4) DEFAULT 0 COMMENT 'Is this the billing address.',
  `street_address` varchar(96) DEFAULT NULL COMMENT 'Concatenation of all routable street address components (prefix, street number, street name, suffix, unit number OR P.O. Box). Apps should be able to determine physical location with this data (for mapping, mail delivery, etc.).',
  `street_number` int(11) DEFAULT NULL COMMENT 'Numeric portion of address number on the street, e.g. For 112A Main St, the street_number = 112.',
  `street_number_suffix` varchar(8) DEFAULT NULL COMMENT 'Non-numeric portion of address number on the street, e.g. For 112A Main St, the street_number_suffix = A',
  `street_number_predirectional` varchar(8) DEFAULT NULL COMMENT 'Directional prefix, e.g. SE Main St, SE is the prefix.',
  `street_name` varchar(64) DEFAULT NULL COMMENT 'Actual street name, excluding St, Dr, Rd, Ave, e.g. For 112 Main St, the street_name = Main.',
  `street_type` varchar(8) DEFAULT NULL COMMENT 'St, Rd, Dr, etc.',
  `street_number_postdirectional` varchar(8) DEFAULT NULL COMMENT 'Directional prefix, e.g. Main St S, S is the suffix.',
  `street_unit` varchar(16) DEFAULT NULL COMMENT 'Secondary unit designator, e.g. Apt 3 or Unit # 14, or Bldg 1200',
  `supplemental_address_1` varchar(96) DEFAULT NULL COMMENT 'Supplemental Address Information, Line 1',
  `supplemental_address_2` varchar(96) DEFAULT NULL COMMENT 'Supplemental Address Information, Line 2',
  `supplemental_address_3` varchar(96) DEFAULT NULL COMMENT 'Supplemental Address Information, Line 3',
  `city` varchar(64) DEFAULT NULL COMMENT 'City, Town or Village Name.',
  `county_id` int(10) unsigned DEFAULT NULL COMMENT 'Which County does this address belong to.',
  `state_province_id` int(10) unsigned DEFAULT NULL COMMENT 'Which State_Province does this address belong to.',
  `postal_code_suffix` varchar(12) DEFAULT NULL COMMENT 'Store the suffix, like the +4 part in the USPS system.',
  `postal_code` varchar(64) DEFAULT NULL,
  `usps_adc` varchar(32) DEFAULT NULL COMMENT 'USPS Bulk mailing code.',
  `country_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Country does this address belong to.',
  `geo_code_1` double DEFAULT NULL COMMENT 'Latitude',
  `geo_code_2` double DEFAULT NULL COMMENT 'Longitude',
  `timezone` varchar(8) DEFAULT NULL COMMENT 'Timezone expressed as a UTC offset - e.g. United States CST would be written as "UTC-6".',
  `name` varchar(255) DEFAULT NULL,
  `master_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Address ID',
  `manual_geo_code` tinyint(4) DEFAULT 0 COMMENT 'Is this a manually entered geo code.',
  PRIMARY KEY (`id`),
  KEY `index_location_type` (`location_type_id`),
  KEY `index_is_primary` (`is_primary`),
  KEY `index_is_billing` (`is_billing`),
  KEY `index_street_name` (`street_name`),
  KEY `index_city` (`city`),
  KEY `FK_civicrm_address_contact_id` (`contact_id`),
  KEY `FK_civicrm_address_county_id` (`county_id`),
  KEY `FK_civicrm_address_state_province_id` (`state_province_id`),
  KEY `FK_civicrm_address_country_id` (`country_id`),
  KEY `FK_civicrm_address_master_id` (`master_id`)
);

DROP TABLE IF EXISTS `civicrm_address_format`;
CREATE TABLE `civicrm_address_format` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Format Id',
  `format` text DEFAULT NULL COMMENT 'The format of an address',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_batch`;
CREATE TABLE `civicrm_batch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Address ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Variable name/programmatic handle for this batch.',
  `title` varchar(64) DEFAULT NULL COMMENT 'Friendly Name.',
  `description` text DEFAULT NULL COMMENT 'Description of this batch set.',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `created_date` datetime DEFAULT NULL COMMENT 'When was this item created',
  `modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `modified_date` datetime DEFAULT NULL COMMENT 'When was this item created',
  `saved_search_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Saved Search ID',
  `status_id` int(10) unsigned NOT NULL COMMENT 'fk to Batch Status options in civicrm_option_values',
  `type_id` int(10) unsigned DEFAULT NULL COMMENT 'fk to Batch Type options in civicrm_option_values',
  `mode_id` int(10) unsigned DEFAULT NULL COMMENT 'fk to Batch mode options in civicrm_option_values',
  `total` decimal(20,2) DEFAULT NULL COMMENT 'Total amount for this batch.',
  `item_count` int(10) unsigned DEFAULT NULL COMMENT 'Number of items in a batch.',
  `payment_instrument_id` int(10) unsigned DEFAULT NULL COMMENT 'fk to Payment Instrument options in civicrm_option_values',
  `exported_date` datetime DEFAULT NULL,
  `data` longtext DEFAULT NULL COMMENT 'cache entered data',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`),
  KEY `FK_civicrm_batch_created_id` (`created_id`),
  KEY `FK_civicrm_batch_modified_id` (`modified_id`),
  KEY `FK_civicrm_batch_saved_search_id` (`saved_search_id`)
);

DROP TABLE IF EXISTS `civicrm_cache`;
CREATE TABLE `civicrm_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(32) NOT NULL COMMENT 'group name for cache element, useful in cleaning cache elements',
  `path` varchar(255) DEFAULT NULL COMMENT 'Unique path name for cache element',
  `data` longtext DEFAULT NULL COMMENT 'data associated with this path',
  `component_id` int(10) unsigned DEFAULT NULL COMMENT 'Component that this menu item belongs to',
  `created_date` datetime DEFAULT NULL COMMENT 'When was the cache item created',
  `expired_date` datetime DEFAULT NULL COMMENT 'When should the cache item expire',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_group_path_date` (`group_name`,`path`,`created_date`),
  KEY `FK_civicrm_cache_component_id` (`component_id`)
);

DROP TABLE IF EXISTS `civicrm_campaign`;
CREATE TABLE `civicrm_campaign` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Campaign ID.',
  `name` varchar(255) NOT NULL COMMENT 'Name of the Campaign.',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title of the Campaign.',
  `description` text DEFAULT NULL COMMENT 'Full description of Campaign.',
  `start_date` datetime DEFAULT NULL COMMENT 'Date and time that Campaign starts.',
  `end_date` datetime DEFAULT NULL COMMENT 'Date and time that Campaign ends.',
  `campaign_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Campaign Type ID.Implicit FK to civicrm_option_value where option_group = campaign_type',
  `status_id` int(10) unsigned DEFAULT NULL COMMENT 'Campaign status ID.Implicit FK to civicrm_option_value where option_group = campaign_status',
  `external_identifier` varchar(32) DEFAULT NULL COMMENT 'Unique trusted external ID (generally from a legacy app/datasource). Particularly useful for deduping operations.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional parent id for this Campaign.',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this Campaign enabled or disabled/cancelled?',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this Campaign.',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time that Campaign was created.',
  `last_modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who recently edited this Campaign.',
  `last_modified_date` datetime DEFAULT NULL COMMENT 'Date and time that Campaign was edited last time.',
  `goal_general` text DEFAULT NULL COMMENT 'General goals for Campaign.',
  `goal_revenue` decimal(20,2) DEFAULT NULL COMMENT 'The target revenue for this campaign.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_external_identifier` (`external_identifier`),
  KEY `UI_campaign_type_id` (`campaign_type_id`),
  KEY `UI_campaign_status_id` (`status_id`),
  KEY `FK_civicrm_campaign_parent_id` (`parent_id`),
  KEY `FK_civicrm_campaign_created_id` (`created_id`),
  KEY `FK_civicrm_campaign_last_modified_id` (`last_modified_id`)
);

DROP TABLE IF EXISTS `civicrm_campaign_group`;
CREATE TABLE `civicrm_campaign_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Campaign Group id.',
  `campaign_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the activity Campaign.',
  `group_type` varchar(8) DEFAULT NULL COMMENT 'Type of Group.',
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Entity id of referenced table.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_campaign_group_campaign_id` (`campaign_id`)
);

DROP TABLE IF EXISTS `civicrm_case`;
CREATE TABLE `civicrm_case` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Case ID',
  `case_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_case_type.id',
  `subject` varchar(128) DEFAULT NULL COMMENT 'Short name of the case.',
  `start_date` date DEFAULT NULL COMMENT 'Date on which given case starts.',
  `end_date` date DEFAULT NULL COMMENT 'Date on which given case ends.',
  `details` text DEFAULT NULL COMMENT 'Details about the meeting (agenda, notes, etc).',
  `status_id` int(10) unsigned NOT NULL COMMENT 'Id of case status.',
  `is_deleted` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `index_case_type_id` (`case_type_id`),
  KEY `index_is_deleted` (`is_deleted`)
);

DROP TABLE IF EXISTS `civicrm_case_activity`;
CREATE TABLE `civicrm_case_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique case-activity association id',
  `case_id` int(10) unsigned NOT NULL COMMENT 'Case ID of case-activity association.',
  `activity_id` int(10) unsigned NOT NULL COMMENT 'Activity ID of case-activity association.',
  PRIMARY KEY (`id`),
  KEY `UI_case_activity_id` (`case_id`,`activity_id`),
  KEY `FK_civicrm_case_activity_activity_id` (`activity_id`)
);

DROP TABLE IF EXISTS `civicrm_case_contact`;
CREATE TABLE `civicrm_case_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique case-contact association id',
  `case_id` int(10) unsigned NOT NULL COMMENT 'Case ID of case-contact association.',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Contact ID of contact record given case belongs to.',
  PRIMARY KEY (`id`),
  KEY `UI_case_contact_id` (`case_id`,`contact_id`),
  KEY `FK_civicrm_case_contact_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_case_type`;
CREATE TABLE `civicrm_case_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Autoincremented type id',
  `name` varchar(64) NOT NULL COMMENT 'Machine name for Case Type',
  `title` varchar(64) NOT NULL COMMENT 'Natural language name for Case Type',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of the Case Type',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this entry active?',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this case type a predefined system type?',
  `weight` int(11) NOT NULL DEFAULT 1 COMMENT 'Ordering of the case types',
  `definition` blob DEFAULT NULL COMMENT 'xml definition of case type',
  PRIMARY KEY (`id`),
  UNIQUE KEY `case_type_name` (`name`)
);

DROP TABLE IF EXISTS `civicrm_component`;
CREATE TABLE `civicrm_component` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Component ID',
  `name` varchar(64) NOT NULL COMMENT 'Name of the component.',
  `namespace` varchar(128) DEFAULT NULL COMMENT 'Path to components main directory in a form of a class\nnamespace.',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_contact`;
CREATE TABLE `civicrm_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Contact ID',
  `contact_type` varchar(64) DEFAULT NULL COMMENT 'Type of Contact.',
  `contact_sub_type` varchar(255) DEFAULT NULL COMMENT 'May be used to over-ride contact view and edit templates.',
  `do_not_email` tinyint(4) DEFAULT 0,
  `do_not_phone` tinyint(4) DEFAULT 0,
  `do_not_mail` tinyint(4) DEFAULT 0,
  `do_not_sms` tinyint(4) DEFAULT 0,
  `do_not_trade` tinyint(4) DEFAULT 0,
  `is_opt_out` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Has the contact opted out from receiving all bulk email from the organization or site domain?',
  `legal_identifier` varchar(32) DEFAULT NULL COMMENT 'May be used for SSN, EIN/TIN, Household ID (census) or other applicable unique legal/government ID.',
  `external_identifier` varchar(64) DEFAULT NULL,
  `sort_name` varchar(128) DEFAULT NULL COMMENT 'Name used for sorting different contact types',
  `display_name` varchar(128) DEFAULT NULL COMMENT 'Formatted name representing preferred format for display/print/other output.',
  `nick_name` varchar(128) DEFAULT NULL COMMENT 'Nick Name.',
  `legal_name` varchar(128) DEFAULT NULL COMMENT 'Legal Name.',
  `image_URL` text DEFAULT NULL COMMENT 'optional URL for preferred image (photo, logo, etc.) to display for this contact.',
  `preferred_communication_method` varchar(255) DEFAULT NULL COMMENT 'What is the preferred mode of communication.',
  `preferred_language` varchar(5) DEFAULT NULL COMMENT 'Which language is preferred for communication. FK to languages in civicrm_option_value.',
  `preferred_mail_format` varchar(8) DEFAULT 'Both' COMMENT 'What is the preferred mode of sending an email.',
  `hash` varchar(32) DEFAULT NULL COMMENT 'Key for validating requests related to this contact.',
  `api_key` varchar(32) DEFAULT NULL COMMENT 'API Key for validating requests related to this contact.',
  `source` varchar(255) DEFAULT NULL COMMENT 'where contact come from, e.g. import, donate module insert...',
  `first_name` varchar(64) DEFAULT NULL COMMENT 'First Name.',
  `middle_name` varchar(64) DEFAULT NULL COMMENT 'Middle Name.',
  `last_name` varchar(64) DEFAULT NULL COMMENT 'Last Name.',
  `prefix_id` int(10) unsigned DEFAULT NULL COMMENT 'Prefix or Title for name (Ms, Mr...). FK to prefix ID',
  `suffix_id` int(10) unsigned DEFAULT NULL COMMENT 'Suffix for name (Jr, Sr...). FK to suffix ID',
  `formal_title` varchar(64) DEFAULT NULL COMMENT 'Formal (academic or similar) title in front of name. (Prof., Dr. etc.)',
  `communication_style_id` int(10) unsigned DEFAULT NULL COMMENT 'Communication style (e.g. formal vs. familiar) to use with this contact. FK to communication styles in civicrm_option_value.',
  `email_greeting_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id, that has to be valid registered Email Greeting.',
  `email_greeting_custom` varchar(128) DEFAULT NULL COMMENT 'Custom Email Greeting.',
  `email_greeting_display` varchar(255) DEFAULT NULL COMMENT 'Cache Email Greeting.',
  `postal_greeting_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id, that has to be valid registered Postal Greeting.',
  `postal_greeting_custom` varchar(128) DEFAULT NULL COMMENT 'Custom Postal greeting.',
  `postal_greeting_display` varchar(255) DEFAULT NULL COMMENT 'Cache Postal greeting.',
  `addressee_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id, that has to be valid registered Addressee.',
  `addressee_custom` varchar(128) DEFAULT NULL COMMENT 'Custom Addressee.',
  `addressee_display` varchar(255) DEFAULT NULL COMMENT 'Cache Addressee.',
  `job_title` varchar(255) DEFAULT NULL COMMENT 'Job Title',
  `gender_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to gender ID',
  `birth_date` date DEFAULT NULL COMMENT 'Date of birth',
  `is_deceased` tinyint(4) DEFAULT 0,
  `deceased_date` date DEFAULT NULL COMMENT 'Date of deceased',
  `household_name` varchar(128) DEFAULT NULL COMMENT 'Household Name.',
  `primary_contact_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional FK to Primary Contact for this household.',
  `organization_name` varchar(128) DEFAULT NULL COMMENT 'Organization Name.',
  `sic_code` varchar(8) DEFAULT NULL COMMENT 'Standard Industry Classification Code.',
  `user_unique_id` varchar(255) DEFAULT NULL COMMENT 'the OpenID (or OpenID-style http://username.domain/) unique identifier for this contact mainly used for logging in to CiviCRM',
  `employer_id` int(10) unsigned DEFAULT NULL COMMENT 'OPTIONAL FK to civicrm_contact record.',
  `is_deleted` tinyint(4) NOT NULL DEFAULT 0,
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'When was the contact was created.',
  `modified_date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'When was the contact (or closely related entity) was created or modified or deleted.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_external_identifier` (`external_identifier`),
  KEY `index_contact_type` (`contact_type`),
  KEY `index_contact_sub_type` (`contact_sub_type`),
  KEY `index_sort_name` (`sort_name`),
  KEY `index_preferred_communication_method` (`preferred_communication_method`),
  KEY `index_hash` (`hash`),
  KEY `index_api_key` (`api_key`),
  KEY `index_first_name` (`first_name`),
  KEY `index_last_name` (`last_name`),
  KEY `UI_prefix` (`prefix_id`),
  KEY `UI_suffix` (`suffix_id`),
  KEY `UI_gender` (`gender_id`),
  KEY `index_household_name` (`household_name`),
  KEY `index_organization_name` (`organization_name`),
  KEY `FK_civicrm_contact_primary_contact_id` (`primary_contact_id`),
  KEY `FK_civicrm_contact_employer_id` (`employer_id`),
  KEY `index_is_deleted_sort_name` (`is_deleted`,`sort_name`,`id`),
  KEY `dedupe_index_birth_date` (`birth_date`),
  KEY `index_communication_style_id` (`communication_style_id`),
  KEY `index_image_URL_128` (`image_URL`(128))
);

DROP TABLE IF EXISTS `civicrm_contact_type`;
CREATE TABLE `civicrm_contact_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contact Type ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Internal name of Contact Type (or Subtype).',
  `label` varchar(64) DEFAULT NULL COMMENT 'localized Name of Contact Type.',
  `description` text DEFAULT NULL COMMENT 'localized Optional verbose description of the type.',
  `image_URL` varchar(255) DEFAULT NULL COMMENT 'URL of image if any.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional FK to parent contact type.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this entry active?',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this contact type a predefined system type',
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_type` (`name`),
  KEY `FK_civicrm_contact_type_parent_id` (`parent_id`)
);

DROP TABLE IF EXISTS `civicrm_contribution`;
CREATE TABLE `civicrm_contribution` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Financial Type for (total_amount - non_deductible_amount).',
  `contribution_page_id` int(10) unsigned DEFAULT NULL COMMENT 'The Contribution Page which triggered this contribution',
  `payment_instrument_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Payment Instrument',
  `receive_date` datetime DEFAULT NULL COMMENT 'when was gift received',
  `non_deductible_amount` decimal(20,2) DEFAULT 0.00 COMMENT 'Portion of total amount which is NOT tax deductible. Equal to total_amount for non-deductible contribution types.',
  `total_amount` decimal(20,2) NOT NULL COMMENT 'Total amount of this contribution. Use market value for non-monetary gifts.',
  `fee_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual processor fee if known - may be 0.',
  `net_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual funds transfer amount. total less fees. if processor does not report actual fee during transaction, this is set to total_amount.',
  `trxn_id` varchar(255) DEFAULT NULL COMMENT 'unique transaction id. may be processor id, bank id + trans id, or account number + check number... depending on payment_method',
  `invoice_id` varchar(255) DEFAULT NULL COMMENT 'unique invoice id, system generated or passed in',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `cancel_date` datetime DEFAULT NULL COMMENT 'when was gift cancelled',
  `cancel_reason` text DEFAULT NULL,
  `receipt_date` datetime DEFAULT NULL COMMENT 'when (if) receipt was sent. populated automatically for online donations w/ automatic receipting',
  `thankyou_date` datetime DEFAULT NULL COMMENT 'when (if) was donor thanked',
  `source` varchar(255) DEFAULT NULL COMMENT 'Origin of this Contribution.',
  `amount_level` text DEFAULT NULL,
  `contribution_recur_id` int(10) unsigned DEFAULT NULL COMMENT 'Conditional foreign key to civicrm_contribution_recur id. Each contribution made in connection with a recurring contribution carries a foreign key to the recurring contribution record. This assumes we can track these processor initiated events.',
  `is_test` tinyint(4) DEFAULT 0,
  `is_pay_later` tinyint(4) DEFAULT 0,
  `contribution_status_id` int(10) unsigned DEFAULT 1,
  `address_id` int(10) unsigned DEFAULT NULL COMMENT 'Conditional foreign key to civicrm_address.id. We insert an address record for each contribution when we have associated billing name and address data.',
  `check_number` varchar(255) DEFAULT NULL,
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'The campaign for which this contribution has been triggered.',
  `tax_amount` decimal(20,2) DEFAULT NULL COMMENT 'Total tax amount of this contribution.',
  `creditnote_id` varchar(255) DEFAULT NULL COMMENT 'unique credit note id, system generated or passed in',
  `revenue_recognition_date` datetime DEFAULT NULL COMMENT 'Stores the date when revenue should be recognized.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contrib_trxn_id` (`trxn_id`),
  UNIQUE KEY `UI_contrib_invoice_id` (`invoice_id`),
  KEY `UI_contrib_payment_instrument_id` (`payment_instrument_id`),
  KEY `index_contribution_status` (`contribution_status_id`),
  KEY `received_date` (`receive_date`),
  KEY `check_number` (`check_number`),
  KEY `FK_civicrm_contribution_contact_id` (`contact_id`),
  KEY `FK_civicrm_contribution_contribution_page_id` (`contribution_page_id`),
  KEY `FK_civicrm_contribution_contribution_recur_id` (`contribution_recur_id`),
  KEY `FK_civicrm_contribution_address_id` (`address_id`),
  KEY `FK_civicrm_contribution_campaign_id` (`campaign_id`),
  KEY `FK_civicrm_contribution_financial_type_id` (`financial_type_id`),
  KEY `index_creditnote_id` (`creditnote_id`),
  KEY `index_source` (`source`),
  KEY `index_total_amount_receive_date` (`total_amount`,`receive_date`)
);

DROP TABLE IF EXISTS `civicrm_contribution_page`;
CREATE TABLE `civicrm_contribution_page` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Contribution Page title. For top of page display',
  `intro_text` text DEFAULT NULL COMMENT 'Text and html allowed. Displayed below title.',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'default financial type assigned to contributions submitted via this page, e.g. Contribution, Campaign Contribution',
  `payment_processor` varchar(128) DEFAULT NULL COMMENT 'Payment Processors configured for this contribution Page ',
  `is_credit_card_only` tinyint(4) DEFAULT 0 COMMENT 'if true - processing logic must reject transaction at confirmation stage if pay method != credit card',
  `is_monetary` tinyint(4) DEFAULT 1 COMMENT 'if true - allows real-time monetary transactions otherwise non-monetary transactions',
  `is_recur` tinyint(4) DEFAULT 0 COMMENT 'if true - allows recurring contributions, valid only for PayPal_Standard',
  `is_confirm_enabled` tinyint(4) DEFAULT 1 COMMENT 'if false, the confirm page in contribution pages gets skipped',
  `recur_frequency_unit` varchar(128) DEFAULT NULL COMMENT 'Supported recurring frequency units.',
  `is_recur_interval` tinyint(4) DEFAULT 0 COMMENT 'if true - supports recurring intervals',
  `is_pay_later` tinyint(4) DEFAULT 0 COMMENT 'if true - allows the user to send payment directly to the org later',
  `pay_later_text` text DEFAULT NULL COMMENT 'The text displayed to the user in the main form',
  `pay_later_receipt` text DEFAULT NULL COMMENT 'The receipt sent to the user instead of the normal receipt text',
  `is_allow_other_amount` tinyint(4) DEFAULT 0 COMMENT 'if true, page will include an input text field where user can enter their own amount',
  `default_amount_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.',
  `min_amount` decimal(20,2) DEFAULT NULL COMMENT 'if other amounts allowed, user can configure minimum allowed.',
  `max_amount` decimal(20,2) DEFAULT NULL COMMENT 'if other amounts allowed, user can configure maximum allowed.',
  `goal_amount` decimal(20,2) DEFAULT NULL COMMENT 'The target goal for this page, allows people to build a goal meter',
  `thankyou_title` varchar(255) DEFAULT NULL COMMENT 'Title for Thank-you page (header title tag, and display at the top of the page).',
  `thankyou_text` text DEFAULT NULL COMMENT 'text and html allowed. displayed above result on success page',
  `thankyou_footer` text DEFAULT NULL COMMENT 'Text and html allowed. displayed at the bottom of the success page. Common usage is to include link(s) to other pages such as tell-a-friend, etc.',
  `is_email_receipt` tinyint(4) DEFAULT 0 COMMENT 'if true, receipt is automatically emailed to contact on success',
  `receipt_from_name` varchar(255) DEFAULT NULL COMMENT 'FROM email name used for receipts generated by contributions to this contribution page.',
  `receipt_from_email` varchar(255) DEFAULT NULL COMMENT 'FROM email address used for receipts generated by contributions to this contribution page.',
  `cc_receipt` varchar(255) DEFAULT NULL COMMENT 'comma-separated list of email addresses to cc each time a receipt is sent',
  `bcc_receipt` varchar(255) DEFAULT NULL COMMENT 'comma-separated list of email addresses to bcc each time a receipt is sent',
  `receipt_text` text DEFAULT NULL COMMENT 'text to include above standard receipt info on receipt email. emails are text-only, so do not allow html for now',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `footer_text` text DEFAULT NULL COMMENT 'Text and html allowed. Displayed at the bottom of the first page of the contribution wizard.',
  `amount_block_is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this property active?',
  `start_date` datetime DEFAULT NULL COMMENT 'Date and time that this page starts.',
  `end_date` datetime DEFAULT NULL COMMENT 'Date and time that this page ends. May be NULL if no defined end date/time',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this contribution page',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time that contribution page was created.',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'The campaign for which we are collecting contributions with this page.',
  `is_share` tinyint(4) DEFAULT 1 COMMENT 'Can people share the contribution page through social media?',
  `is_recur_installments` tinyint(4) DEFAULT 0,
  `adjust_recur_start_date` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'If true - user is able to adjust payment start date.',
  `is_partial_payment` tinyint(4) DEFAULT 0 COMMENT 'is partial payment enabled for this event',
  `min_initial_amount` decimal(20,2) DEFAULT NULL COMMENT 'Minimum initial amount for partial payment',
  `initial_amount_label` varchar(255) DEFAULT NULL COMMENT 'Initial amount label for partial payment',
  `initial_amount_help_text` text DEFAULT NULL COMMENT 'Initial amount help text for partial payment',
  `is_billing_required` tinyint(4) DEFAULT 0 COMMENT 'Billing block required for Contribution Page',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_contribution_page_created_id` (`created_id`),
  KEY `FK_civicrm_contribution_page_campaign_id` (`campaign_id`),
  KEY `FK_civicrm_contribution_page_financial_type_id` (`financial_type_id`)
);

DROP TABLE IF EXISTS `civicrm_contribution_product`;
CREATE TABLE `civicrm_contribution_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `contribution_id` int(10) unsigned NOT NULL,
  `product_option` varchar(255) DEFAULT NULL COMMENT 'Option value selected if applicable - e.g. color, size etc.',
  `quantity` int(11) DEFAULT NULL,
  `fulfilled_date` date DEFAULT NULL COMMENT 'Optional. Can be used to record the date this product was fulfilled or shipped.',
  `start_date` date DEFAULT NULL COMMENT 'Actual start date for a time-delimited premium (subscription, service or membership)',
  `end_date` date DEFAULT NULL COMMENT 'Actual end date for a time-delimited premium (subscription, service or membership)',
  `comment` text DEFAULT NULL,
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Financial Type.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_contribution_product_contribution_id` (`contribution_id`),
  KEY `FK_civicrm_contribution_product_financial_type_id` (`financial_type_id`)
);

DROP TABLE IF EXISTS `civicrm_contribution_recur`;
CREATE TABLE `civicrm_contribution_recur` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution Recur ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to civicrm_contact.id .',
  `amount` decimal(20,2) NOT NULL COMMENT 'Amount to be contributed or charged each recurrence.',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `frequency_unit` varchar(8) DEFAULT 'month' COMMENT 'Time units for recurrence of payment.',
  `frequency_interval` int(10) unsigned NOT NULL COMMENT 'Number of time units for recurrence of payment.',
  `installments` int(10) unsigned DEFAULT NULL COMMENT 'Total number of payments to be made. Set this to 0 if this is an open-ended commitment i.e. no set end date.',
  `start_date` datetime NOT NULL COMMENT 'The date the first scheduled recurring contribution occurs.',
  `create_date` datetime NOT NULL COMMENT 'When this recurring contribution record was created.',
  `modified_date` datetime DEFAULT NULL COMMENT 'Last updated date for this record. mostly the last time a payment was received',
  `cancel_date` datetime DEFAULT NULL COMMENT 'Date this recurring contribution was cancelled by contributor- if we can get access to it',
  `end_date` datetime DEFAULT NULL COMMENT 'Date this recurring contribution finished successfully',
  `processor_id` varchar(255) DEFAULT NULL COMMENT 'Possibly needed to store a unique identifier for this recurring payment order - if this is available from the processor??',
  `trxn_id` varchar(255) DEFAULT NULL COMMENT 'unique transaction id. may be processor id, bank id + trans id, or account number + check number... depending on payment_method',
  `invoice_id` varchar(255) DEFAULT NULL COMMENT 'unique invoice id, system generated or passed in',
  `contribution_status_id` int(10) unsigned DEFAULT 1,
  `is_test` tinyint(4) DEFAULT 0,
  `cycle_day` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'Day in the period when the payment should be charged e.g. 1st of month, 15th etc.',
  `next_sched_contribution_date` datetime DEFAULT NULL COMMENT 'At Groundspring this was used by the cron job which triggered payments. If we''re not doing that but we know about payments, it might still be useful to store for display to org andor contributors.',
  `failure_count` int(10) unsigned DEFAULT 0 COMMENT 'Number of failed charge attempts since last success. Business rule could be set to deactivate on more than x failures.',
  `failure_retry_date` datetime DEFAULT NULL COMMENT 'At Groundspring we set a business rule to retry failed payments every 7 days - and stored the next scheduled attempt date there.',
  `auto_renew` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Some systems allow contributor to set a number of installments - but then auto-renew the subscription or commitment if they do not cancel.',
  `payment_processor_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to civicrm_payment_processor.id',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Financial Type',
  `payment_instrument_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Payment Instrument',
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'The campaign for which this contribution has been triggered.',
  `is_email_receipt` tinyint(4) DEFAULT 1 COMMENT 'if true, receipt is automatically emailed to contact on each successful payment',
  `payment_token_id` int(10) unsigned DEFAULT NULL COMMENT 'Optionally used to store a link to a payment token used for this recurring contribution.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contrib_trxn_id` (`trxn_id`),
  UNIQUE KEY `UI_contrib_invoice_id` (`invoice_id`),
  KEY `index_contribution_status` (`contribution_status_id`),
  KEY `UI_contribution_recur_payment_instrument_id` (`payment_instrument_id`),
  KEY `FK_civicrm_contribution_recur_contact_id` (`contact_id`),
  KEY `FK_civicrm_contribution_recur_payment_processor_id` (`payment_processor_id`),
  KEY `FK_civicrm_contribution_recur_campaign_id` (`campaign_id`),
  KEY `FK_civicrm_contribution_recur_financial_type_id` (`financial_type_id`),
  KEY `FK_civicrm_contribution_recur_payment_token_id` (`payment_token_id`)
);

DROP TABLE IF EXISTS `civicrm_contribution_soft`;
CREATE TABLE `civicrm_contribution_soft` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Soft Contribution ID',
  `contribution_id` int(10) unsigned NOT NULL COMMENT 'FK to contribution table.',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID',
  `amount` decimal(20,2) NOT NULL COMMENT 'Amount of this soft contribution.',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `pcp_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_pcp.id',
  `pcp_display_in_roll` tinyint(4) DEFAULT 0,
  `pcp_roll_nickname` varchar(255) DEFAULT NULL,
  `pcp_personal_note` varchar(255) DEFAULT NULL,
  `soft_credit_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Soft Credit Type ID.Implicit FK to civicrm_option_value where option_group = soft_credit_type.',
  PRIMARY KEY (`id`),
  KEY `index_id` (`pcp_id`),
  KEY `FK_civicrm_contribution_soft_contribution_id` (`contribution_id`),
  KEY `FK_civicrm_contribution_soft_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_contribution_widget`;
CREATE TABLE `civicrm_contribution_widget` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution Id',
  `contribution_page_id` int(10) unsigned DEFAULT NULL COMMENT 'The Contribution Page which triggered this contribution',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `title` varchar(255) DEFAULT NULL COMMENT 'Widget title.',
  `url_logo` varchar(255) DEFAULT NULL COMMENT 'URL to Widget logo',
  `button_title` varchar(255) DEFAULT NULL COMMENT 'Button title.',
  `about` text DEFAULT NULL COMMENT 'About description.',
  `url_homepage` varchar(255) DEFAULT NULL COMMENT 'URL to Homepage.',
  `color_title` varchar(10) DEFAULT NULL,
  `color_button` varchar(10) DEFAULT NULL,
  `color_bar` varchar(10) DEFAULT NULL,
  `color_main_text` varchar(10) DEFAULT NULL,
  `color_main` varchar(10) DEFAULT NULL,
  `color_main_bg` varchar(10) DEFAULT NULL,
  `color_bg` varchar(10) DEFAULT NULL,
  `color_about_link` varchar(10) DEFAULT NULL,
  `color_homepage_link` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_contribution_widget_contribution_page_id` (`contribution_page_id`)
);

DROP TABLE IF EXISTS `civicrm_country`;
CREATE TABLE `civicrm_country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Id',
  `name` varchar(64) DEFAULT NULL COMMENT 'Country Name',
  `iso_code` char(2) DEFAULT NULL COMMENT 'ISO Code',
  `country_code` varchar(4) DEFAULT NULL COMMENT 'National prefix to be used when dialing TO this country.',
  `address_format_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to civicrm_address_format.id.',
  `idd_prefix` varchar(4) DEFAULT NULL COMMENT 'International direct dialing prefix from within the country TO another country',
  `ndd_prefix` varchar(4) DEFAULT NULL COMMENT 'Access prefix to call within a country to a different area',
  `region_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to civicrm_worldregion.id.',
  `is_province_abbreviated` tinyint(4) DEFAULT 0 COMMENT 'Should state/province be displayed as abbreviation for contacts from this country?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_iso_code` (`name`,`iso_code`),
  KEY `FK_civicrm_country_address_format_id` (`address_format_id`),
  KEY `FK_civicrm_country_region_id` (`region_id`)
);

DROP TABLE IF EXISTS `civicrm_county`;
CREATE TABLE `civicrm_county` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'County ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Name of County',
  `abbreviation` varchar(4) DEFAULT NULL COMMENT '2-4 Character Abbreviation of County',
  `state_province_id` int(10) unsigned NOT NULL COMMENT 'ID of State / Province that County belongs',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_state_id` (`name`,`state_province_id`),
  KEY `FK_civicrm_county_state_province_id` (`state_province_id`)
);

DROP TABLE IF EXISTS `civicrm_currency`;

CREATE TABLE `civicrm_currency` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Currency Id',
  `name` varchar(64) DEFAULT NULL COMMENT 'Currency Name',
  `symbol` varchar(8) DEFAULT NULL COMMENT 'Currency Symbol',
  `numeric_code` varchar(3) DEFAULT NULL COMMENT 'Numeric currency code',
  `full_name` varchar(64) DEFAULT NULL COMMENT 'Full currency name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`)
);

DROP TABLE IF EXISTS `civicrm_custom_field`;

CREATE TABLE `civicrm_custom_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Custom Field ID',
  `custom_group_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_custom_group.',
  `name` varchar(64) DEFAULT NULL COMMENT 'Variable name/programmatic handle for this group.',
  `label` varchar(255) NOT NULL COMMENT 'Text for form field label (also friendly name for administering this custom property).',
  `data_type` varchar(16) NOT NULL COMMENT 'Controls location of data storage in extended_data table.',
  `html_type` varchar(32) NOT NULL COMMENT 'HTML types plus several built-in extended types.',
  `default_value` varchar(255) DEFAULT NULL COMMENT 'Use form_options.is_default for field_types which use options.',
  `is_required` tinyint(4) DEFAULT NULL COMMENT 'Is a value required for this property.',
  `is_searchable` tinyint(4) DEFAULT NULL COMMENT 'Is this property searchable.',
  `is_search_range` tinyint(4) DEFAULT 0 COMMENT 'Is this property range searchable.',
  `weight` int(11) NOT NULL DEFAULT 1 COMMENT 'Controls field display order within an extended property group.',
  `help_pre` text DEFAULT NULL COMMENT 'Description and/or help text to display before this field.',
  `help_post` text DEFAULT NULL COMMENT 'Description and/or help text to display after this field.',
  `mask` varchar(64) DEFAULT NULL COMMENT 'Optional format instructions for specific field types, like date types.',
  `attributes` varchar(255) DEFAULT NULL COMMENT 'Store collection of type-appropriate attributes, e.g. textarea  needs rows/cols attributes',
  `javascript` varchar(255) DEFAULT NULL COMMENT 'Optional scripting attributes for field.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `is_view` tinyint(4) DEFAULT NULL COMMENT 'Is this property set by PHP Code? A code field is viewable but not editable',
  `options_per_line` int(10) unsigned DEFAULT NULL COMMENT 'number of options per line for checkbox and radio',
  `text_length` int(10) unsigned DEFAULT NULL COMMENT 'field length if alphanumeric',
  `start_date_years` int(11) DEFAULT NULL COMMENT 'Date may be up to start_date_years years prior to the current date.',
  `end_date_years` int(11) DEFAULT NULL COMMENT 'Date may be up to end_date_years years after the current date.',
  `date_format` varchar(64) DEFAULT NULL COMMENT 'date format for custom date',
  `time_format` int(10) unsigned DEFAULT NULL COMMENT 'time format for custom date',
  `note_columns` int(10) unsigned DEFAULT NULL COMMENT ' Number of columns in Note Field ',
  `note_rows` int(10) unsigned DEFAULT NULL COMMENT ' Number of rows in Note Field ',
  `column_name` varchar(255) DEFAULT NULL COMMENT 'Name of the column that holds the values for this field.',
  `option_group_id` int(10) unsigned DEFAULT NULL COMMENT 'For elements with options, the option group id that is used',
  `filter` varchar(255) DEFAULT NULL COMMENT 'Stores Contact Get API params contact reference custom fields. May be used for other filters in the future.',
  `in_selector` tinyint(4) DEFAULT 0 COMMENT 'Should the multi-record custom field values be displayed in tab table listing',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_label_custom_group_id` (`label`,`custom_group_id`),
  UNIQUE KEY `UI_name_custom_group_id` (`name`,`custom_group_id`),
  KEY `FK_civicrm_custom_field_custom_group_id` (`custom_group_id`)
);

DROP TABLE IF EXISTS `civicrm_custom_group`;

CREATE TABLE `civicrm_custom_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Custom Group ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Variable name/programmatic handle for this group.',
  `title` varchar(64) NOT NULL COMMENT 'Friendly Name.',
  `extends` varchar(255) DEFAULT 'Contact' COMMENT 'Type of object this group extends (can add other options later e.g. contact_address, etc.).',
  `extends_entity_column_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id (for option group custom_data_type.)',
  `extends_entity_column_value` varchar(255) DEFAULT NULL COMMENT 'linking custom group for dynamic object',
  `style` varchar(15) DEFAULT NULL COMMENT 'Visual relationship between this form and its parent.',
  `collapse_display` int(10) unsigned DEFAULT 0 COMMENT 'Will this group be in collapsed or expanded mode on initial display ?',
  `help_pre` text DEFAULT NULL COMMENT 'Description and/or help text to display before fields in form.',
  `help_post` text DEFAULT NULL COMMENT 'Description and/or help text to display after fields in form.',
  `weight` int(11) NOT NULL DEFAULT 1 COMMENT 'Controls display order when multiple extended property groups are setup for the same class.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `table_name` varchar(255) DEFAULT NULL COMMENT 'Name of the table that holds the values for this group.',
  `is_multiple` tinyint(4) DEFAULT NULL COMMENT 'Does this group hold multiple values?',
  `min_multiple` int(10) unsigned DEFAULT NULL COMMENT 'minimum number of multiple records (typically 0?)',
  `max_multiple` int(10) unsigned DEFAULT NULL COMMENT 'maximum number of multiple records, if 0 - no max',
  `collapse_adv_display` int(10) unsigned DEFAULT 0 COMMENT 'Will this group be in collapsed or expanded mode on advanced search display ?',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this custom group',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time this custom group was created.',
  `is_reserved` tinyint(4) DEFAULT 0 COMMENT 'Is this a reserved Custom Group?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_title_extends` (`title`,`extends`),
  UNIQUE KEY `UI_name_extends` (`name`,`extends`),
  KEY `FK_civicrm_custom_group_created_id` (`created_id`)
);

DROP TABLE IF EXISTS `civicrm_cxn`;

CREATE TABLE `civicrm_cxn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Connection ID',
  `app_guid` varchar(128) DEFAULT NULL COMMENT 'Application GUID',
  `app_meta` text DEFAULT NULL COMMENT 'Application Metadata (JSON)',
  `cxn_guid` varchar(128) DEFAULT NULL COMMENT 'Connection GUID',
  `secret` text DEFAULT NULL COMMENT 'Shared secret',
  `perm` text DEFAULT NULL COMMENT 'Permissions approved for the service (JSON)',
  `options` text DEFAULT NULL COMMENT 'Options for the service (JSON)',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is connection currently enabled?',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'When was the connection was created.',
  `modified_date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'When the connection was created or modified.',
  `fetched_date` timestamp NULL DEFAULT NULL COMMENT 'The last time the application metadata was fetched.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_appid` (`app_guid`),
  UNIQUE KEY `UI_keypair_cxnid` (`cxn_guid`)
);

DROP TABLE IF EXISTS `civicrm_dashboard`;

CREATE TABLE `civicrm_dashboard` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Domain for dashboard',
  `name` varchar(64) DEFAULT NULL COMMENT 'Internal name of dashlet.',
  `label` varchar(255) DEFAULT NULL COMMENT 'dashlet title',
  `url` varchar(255) DEFAULT NULL COMMENT 'url in case of external dashlet',
  `permission` varchar(255) DEFAULT NULL COMMENT 'Permission for the dashlet',
  `permission_operator` varchar(3) DEFAULT NULL COMMENT 'Permission Operator',
  `fullscreen_url` varchar(255) DEFAULT NULL COMMENT 'fullscreen url for dashlet',
  `is_active` tinyint(4) DEFAULT 0 COMMENT 'Is this dashlet active?',
  `is_reserved` tinyint(4) DEFAULT 0 COMMENT 'Is this dashlet reserved?',
  `cache_minutes` int(10) unsigned NOT NULL DEFAULT 60 COMMENT 'Number of minutes to cache dashlet content in browser localStorage.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_dashboard_domain_id` (`domain_id`)
);

DROP TABLE IF EXISTS `civicrm_dashboard_contact`;

CREATE TABLE `civicrm_dashboard_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dashboard_id` int(10) unsigned NOT NULL COMMENT 'Dashboard ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Contact ID',
  `column_no` tinyint(4) DEFAULT 0 COMMENT 'column no for this widget',
  `is_active` tinyint(4) DEFAULT 0 COMMENT 'Is this widget active?',
  `weight` int(11) DEFAULT 0 COMMENT 'Ordering of the widgets.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_dashboard_id_contact_id` (`dashboard_id`,`contact_id`),
  KEY `FK_civicrm_dashboard_contact_dashboard_id` (`dashboard_id`),
  KEY `FK_civicrm_dashboard_contact_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_dedupe_exception`;

CREATE TABLE `civicrm_dedupe_exception` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique dedupe exception id',
  `contact_id1` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `contact_id2` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contact_id1_contact_id2` (`contact_id1`,`contact_id2`),
  KEY `FK_civicrm_dedupe_exception_contact_id2` (`contact_id2`)
);

DROP TABLE IF EXISTS `civicrm_dedupe_rule`;

CREATE TABLE `civicrm_dedupe_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique dedupe rule id',
  `dedupe_rule_group_id` int(10) unsigned NOT NULL COMMENT 'The id of the rule group this rule belongs to',
  `rule_table` varchar(64) NOT NULL COMMENT 'The name of the table this rule is about',
  `rule_field` varchar(64) NOT NULL COMMENT 'The name of the field of the table referenced in rule_table',
  `rule_length` int(10) unsigned DEFAULT NULL COMMENT 'The lenght of the matching substring',
  `rule_weight` int(11) NOT NULL COMMENT 'The weight of the rule',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_dedupe_rule_dedupe_rule_group_id` (`dedupe_rule_group_id`)
);

DROP TABLE IF EXISTS `civicrm_dedupe_rule_group`;

CREATE TABLE `civicrm_dedupe_rule_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique dedupe rule group id',
  `contact_type` varchar(12) DEFAULT NULL COMMENT 'The type of contacts this group applies to',
  `threshold` int(11) NOT NULL COMMENT 'The weight threshold the sum of the rule weights has to cross to consider two contacts the same',
  `used` varchar(12) NOT NULL COMMENT 'Whether the rule should be used for cases where usage is Unsupervised, Supervised OR General(programatically)',
  `name` varchar(64) DEFAULT NULL COMMENT 'Name of the rule group',
  `title` varchar(255) DEFAULT NULL COMMENT 'Label of the rule group',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this a reserved rule - a rule group that has been optimized and cannot be changed by the admin',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_discount`;

CREATE TABLE `civicrm_discount` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'physical tablename for entity being joined to discount, e.g. civicrm_event',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `price_set_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_price_set',
  `start_date` date DEFAULT NULL COMMENT 'Date when discount starts.',
  `end_date` date DEFAULT NULL COMMENT 'Date when discount ends.',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `index_entity_option_id` (`entity_table`,`entity_id`,`price_set_id`),
  KEY `FK_civicrm_discount_price_set_id` (`price_set_id`)
);

DROP TABLE IF EXISTS `civicrm_domain`;

CREATE TABLE `civicrm_domain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Domain ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Name of Domain / Organization',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of Domain.',
  `version` varchar(32) DEFAULT NULL COMMENT 'The civicrm version this instance is running',
  `locales` text DEFAULT NULL COMMENT 'list of locales supported by the current db state (NULL for single-lang install)',
  `locale_custom_strings` text DEFAULT NULL COMMENT 'Locale specific string overrides',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID. This is specifically not an FK to avoid circular constraints',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`),
  KEY `FK_civicrm_domain_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_email`;

CREATE TABLE `civicrm_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Email ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this email belong to.',
  `email` varchar(254) DEFAULT NULL,
  `is_primary` tinyint(4) DEFAULT 0 COMMENT 'Is this the primary?',
  `is_billing` tinyint(4) DEFAULT 0 COMMENT 'Is this the billing?',
  `on_hold` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Is this address on bounce hold?',
  `is_bulkmail` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Is this address for bulk mail ?',
  `hold_date` datetime DEFAULT NULL COMMENT 'When the address went on bounce hold',
  `reset_date` datetime DEFAULT NULL COMMENT 'When the address bounce status was last reset',
  `signature_text` text DEFAULT NULL COMMENT 'Text formatted signature for the email.',
  `signature_html` text DEFAULT NULL COMMENT 'HTML formatted signature for the email.',
  PRIMARY KEY (`id`),
  KEY `index_location_type` (`location_type_id`),
  KEY `UI_email` (`email`),
  KEY `index_is_primary` (`is_primary`),
  KEY `index_is_billing` (`is_billing`),
  KEY `FK_civicrm_email_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_entity_batch`;

CREATE TABLE `civicrm_entity_batch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'physical tablename for entity being joined to file, e.g. civicrm_contact',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `batch_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_batch',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_batch_entity` (`batch_id`,`entity_id`,`entity_table`),
  KEY `index_entity` (`entity_table`,`entity_id`)
);

DROP TABLE IF EXISTS `civicrm_entity_file`;

CREATE TABLE `civicrm_entity_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'physical tablename for entity being joined to file, e.g. civicrm_contact',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `file_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_file',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `index_entity_file_id` (`entity_table`,`entity_id`,`file_id`),
  KEY `FK_civicrm_entity_file_file_id` (`file_id`)
);

DROP TABLE IF EXISTS `civicrm_entity_financial_account`;

CREATE TABLE `civicrm_entity_financial_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `entity_table` varchar(64) NOT NULL COMMENT 'Links to an entity_table like civicrm_financial_type',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Links to an id in the entity_table, such as vid in civicrm_financial_type',
  `account_relationship` int(10) unsigned NOT NULL COMMENT 'FK to a new civicrm_option_value (account_relationship)',
  `financial_account_id` int(10) unsigned NOT NULL COMMENT 'FK to the financial_account_id',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_entity_financial_account_financial_account_id` (`financial_account_id`)
);

DROP TABLE IF EXISTS `civicrm_entity_financial_trxn`;

CREATE TABLE `civicrm_entity_financial_trxn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `entity_table` varchar(64) NOT NULL,
  `entity_id` int(10) unsigned NOT NULL,
  `financial_trxn_id` int(10) unsigned DEFAULT NULL,
  `amount` decimal(20,2) NOT NULL COMMENT 'allocated amount of transaction to this entity',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_entity_financial_trxn_financial_trxn_id` (`financial_trxn_id`),
  KEY `UI_entity_financial_trxn_entity_table` (`entity_table`),
  KEY `UI_entity_financial_trxn_entity_id` (`entity_id`)
);

DROP TABLE IF EXISTS `civicrm_entity_tag`;

CREATE TABLE `civicrm_entity_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'physical tablename for entity being joined to file, e.g. civicrm_contact',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `tag_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_tag',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_entity_id_entity_table_tag_id` (`entity_id`,`entity_table`,`tag_id`),
  KEY `FK_civicrm_entity_tag_tag_id` (`tag_id`)
);

DROP TABLE IF EXISTS `civicrm_event`;

CREATE TABLE `civicrm_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event',
  `title` varchar(255) DEFAULT NULL COMMENT 'Event Title (e.g. Fall Fundraiser Dinner)',
  `summary` text DEFAULT NULL COMMENT 'Brief summary of event. Text and html allowed. Displayed on Event Registration form and can be used on other CMS pages which need an event summary.',
  `description` text DEFAULT NULL COMMENT 'Full description of event. Text and html allowed. Displayed on built-in Event Information screens.',
  `event_type_id` int(10) unsigned DEFAULT 0 COMMENT 'Event Type ID.Implicit FK to civicrm_option_value where option_group = event_type.',
  `participant_listing_id` int(10) unsigned DEFAULT 0 COMMENT 'Should we expose the participant list? Implicit FK to civicrm_option_value where option_group = participant_listing.',
  `is_public` tinyint(4) DEFAULT 1 COMMENT 'Public events will be included in the iCal feeds. Access to private event information may be limited using ACLs.',
  `start_date` datetime DEFAULT NULL COMMENT 'Date and time that event starts.',
  `end_date` datetime DEFAULT NULL COMMENT 'Date and time that event ends. May be NULL if no defined end date/time',
  `is_online_registration` tinyint(4) DEFAULT 0 COMMENT 'If true, include registration link on Event Info page.',
  `registration_link_text` varchar(255) DEFAULT NULL COMMENT 'Text for link to Event Registration form which is displayed on Event Information screen when is_online_registration is true.',
  `registration_start_date` datetime DEFAULT NULL COMMENT 'Date and time that online registration starts.',
  `registration_end_date` datetime DEFAULT NULL COMMENT 'Date and time that online registration ends.',
  `max_participants` int(10) unsigned DEFAULT NULL COMMENT 'Maximum number of registered participants to allow. After max is reached, a custom Event Full message is displayed. If NULL, allow unlimited number of participants.',
  `event_full_text` text DEFAULT NULL COMMENT 'Message to display on Event Information page and INSTEAD OF Event Registration form if maximum participants are signed up. Can include email address/info about getting on a waiting list, etc. Text and html allowed.',
  `is_monetary` tinyint(4) DEFAULT 0 COMMENT 'Is this a PAID event? If true, one or more fee amounts must be set and a Payment Processor must be configured for Online Event Registration.',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Financial type assigned to paid event registrations for this event. Required if is_monetary is true.',
  `payment_processor` varchar(128) DEFAULT NULL COMMENT 'Payment Processors configured for this Event (if is_monetary is true)',
  `is_map` tinyint(4) DEFAULT 0 COMMENT 'Include a map block on the Event Information page when geocode info is available and a mapping provider has been specified?',
  `is_active` tinyint(4) DEFAULT 0 COMMENT 'Is this Event enabled or disabled/cancelled?',
  `fee_label` varchar(255) DEFAULT NULL,
  `is_show_location` tinyint(4) DEFAULT 1 COMMENT 'If true, show event location.',
  `loc_block_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Location Block ID',
  `default_role_id` int(10) unsigned DEFAULT 1 COMMENT 'Participant role ID. Implicit FK to civicrm_option_value where option_group = participant_role.',
  `intro_text` text DEFAULT NULL COMMENT 'Introductory message for Event Registration page. Text and html allowed. Displayed at the top of Event Registration form.',
  `footer_text` text DEFAULT NULL COMMENT 'Footer message for Event Registration page. Text and html allowed. Displayed at the bottom of Event Registration form.',
  `confirm_title` varchar(255) DEFAULT NULL COMMENT 'Title for Confirmation page.',
  `confirm_text` text DEFAULT NULL COMMENT 'Introductory message for Event Registration page. Text and html allowed. Displayed at the top of Event Registration form.',
  `confirm_footer_text` text DEFAULT NULL COMMENT 'Footer message for Event Registration page. Text and html allowed. Displayed at the bottom of Event Registration form.',
  `is_email_confirm` tinyint(4) DEFAULT 0 COMMENT 'If true, confirmation is automatically emailed to contact on successful registration.',
  `confirm_email_text` text DEFAULT NULL COMMENT 'text to include above standard event info on confirmation email. emails are text-only, so do not allow html for now',
  `confirm_from_name` varchar(255) DEFAULT NULL COMMENT 'FROM email name used for confirmation emails.',
  `confirm_from_email` varchar(255) DEFAULT NULL COMMENT 'FROM email address used for confirmation emails.',
  `cc_confirm` varchar(255) DEFAULT NULL COMMENT 'comma-separated list of email addresses to cc each time a confirmation is sent',
  `bcc_confirm` varchar(255) DEFAULT NULL COMMENT 'comma-separated list of email addresses to bcc each time a confirmation is sent',
  `default_fee_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.',
  `default_discount_fee_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.',
  `thankyou_title` varchar(255) DEFAULT NULL COMMENT 'Title for ThankYou page.',
  `thankyou_text` text DEFAULT NULL COMMENT 'ThankYou Text.',
  `thankyou_footer_text` text DEFAULT NULL COMMENT 'Footer message.',
  `is_pay_later` tinyint(4) DEFAULT 0 COMMENT 'if true - allows the user to send payment directly to the org later',
  `pay_later_text` text DEFAULT NULL COMMENT 'The text displayed to the user in the main form',
  `pay_later_receipt` text DEFAULT NULL COMMENT 'The receipt sent to the user instead of the normal receipt text',
  `is_multiple_registrations` tinyint(4) DEFAULT 0 COMMENT 'if true - allows the user to register multiple participants for event',
  `max_additional_participants` int(10) unsigned DEFAULT 0 COMMENT 'Maximum number of additional participants that can be registered on a single booking',
  `allow_same_participant_emails` tinyint(4) DEFAULT 0 COMMENT 'if true - allows the user to register multiple registrations from same email address.',
  `has_waitlist` tinyint(4) DEFAULT NULL COMMENT 'Whether the event has waitlist support.',
  `requires_approval` tinyint(4) DEFAULT NULL COMMENT 'Whether participants require approval before they can finish registering.',
  `expiration_time` int(10) unsigned DEFAULT NULL COMMENT 'Expire pending but unconfirmed registrations after this many hours.',
  `waitlist_text` text DEFAULT NULL COMMENT 'Text to display when the event is full, but participants can signup for a waitlist.',
  `approval_req_text` text DEFAULT NULL COMMENT 'Text to display when the approval is required to complete registration for an event.',
  `is_template` tinyint(4) DEFAULT 0 COMMENT 'whether the event has template',
  `template_title` varchar(255) DEFAULT NULL COMMENT 'Event Template Title',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this event',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time that event was created.',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'The campaign for which this event has been created.',
  `is_share` tinyint(4) DEFAULT 1 COMMENT 'Can people share the event through social media?',
  `parent_event_id` int(10) unsigned DEFAULT NULL COMMENT 'Implicit FK to civicrm_event: parent event',
  `slot_label_id` int(10) unsigned DEFAULT NULL COMMENT 'Subevent slot label. Implicit FK to civicrm_option_value where option_group = conference_slot.',
  `is_partial_payment` tinyint(4) DEFAULT 0 COMMENT 'is partial payment enabled for this event',
  `min_initial_amount` decimal(20,2) DEFAULT NULL COMMENT 'Minimum initial amount for partial payment',
  `initial_amount_label` varchar(255) DEFAULT NULL COMMENT 'Initial amount label for partial payment',
  `initial_amount_help_text` text DEFAULT NULL COMMENT 'Initial amount help text for partial payment',
  `is_confirm_enabled` tinyint(4) DEFAULT 1,
  `dedupe_rule_group_id` int(10) unsigned DEFAULT NULL COMMENT 'Rule to use when matching registrations for this event',
  `is_billing_required` tinyint(4) DEFAULT 0 COMMENT 'Billing block required for Event',
  `selfcancelxfer_time` int(10) unsigned DEFAULT 0 COMMENT 'Number of hours prior to event start date to allow self-service cancellation or transfer.',
  `allow_selfcancelxfer` tinyint(4) DEFAULT 0 COMMENT 'Allow self service cancellation or transfer for event?',
  PRIMARY KEY (`id`),
  KEY `index_event_type_id` (`event_type_id`),
  KEY `index_participant_listing_id` (`participant_listing_id`),
  KEY `index_parent_event_id` (`parent_event_id`),
  KEY `FK_civicrm_event_loc_block_id` (`loc_block_id`),
  KEY `FK_civicrm_event_created_id` (`created_id`),
  KEY `FK_civicrm_event_campaign_id` (`campaign_id`),
  KEY `FK_civicrm_event_dedupe_rule_group_id` (`dedupe_rule_group_id`)
);

DROP TABLE IF EXISTS `civicrm_event_carts`;

CREATE TABLE `civicrm_event_carts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cart Id',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact who created this cart',
  `completed` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_event_carts_user_id` (`user_id`)
);

DROP TABLE IF EXISTS `civicrm_events_in_carts`;

CREATE TABLE `civicrm_events_in_carts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event In Cart Id',
  `event_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Event ID',
  `event_cart_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Event Cart ID',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_events_in_carts_event_id` (`event_id`),
  KEY `FK_civicrm_events_in_carts_event_cart_id` (`event_cart_id`)
);

DROP TABLE IF EXISTS `civicrm_extension`;

CREATE TABLE `civicrm_extension` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Local Extension ID',
  `type` varchar(8) NOT NULL,
  `full_name` varchar(255) NOT NULL COMMENT 'Fully qualified extension name',
  `name` varchar(255) DEFAULT NULL COMMENT 'Short name',
  `label` varchar(255) DEFAULT NULL COMMENT 'Short, printable name',
  `file` varchar(255) DEFAULT NULL COMMENT 'Primary PHP file',
  `schema_version` varchar(63) DEFAULT NULL COMMENT 'Revision code of the database schema the format is module-defined',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this extension active?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_extension_full_name` (`full_name`),
  KEY `UI_extension_name` (`name`)
);

DROP TABLE IF EXISTS `civicrm_file`;

CREATE TABLE `civicrm_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique ID',
  `file_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Type of file (e.g. Transcript, Income Tax Return, etc). FK to civicrm_option_value.',
  `mime_type` varchar(255) DEFAULT NULL COMMENT 'mime type of the document',
  `uri` varchar(255) DEFAULT NULL COMMENT 'uri of the file on disk',
  `document` mediumblob DEFAULT NULL COMMENT 'contents of the document',
  `description` varchar(255) DEFAULT NULL COMMENT 'Additional descriptive text regarding this attachment (optional).',
  `upload_date` datetime DEFAULT NULL COMMENT 'Date and time that this attachment was uploaded or written to server.',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_financial_account`;

CREATE TABLE `civicrm_financial_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL,
  `contact_id` int(10) unsigned DEFAULT NULL,
  `financial_account_type_id` int(10) unsigned NOT NULL DEFAULT 3 COMMENT 'Version identifier of financial_type',
  `description` varchar(255) DEFAULT NULL COMMENT 'Financial Type Description.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent ID in account hierarchy',
  `is_header_account` tinyint(4) DEFAULT NULL COMMENT 'Is this a header account which does not allow transactions to be posted against it directly, but only to its sub-accounts?',
  `accounting_code` varchar(64) DEFAULT NULL COMMENT 'Optional value for mapping monies owed and received to accounting system codes.',
  `account_type_code` varchar(64) DEFAULT NULL COMMENT 'Optional value for mapping account types to accounting system account categories (QuickBooks Account Type Codes for example).',
  `is_deductible` tinyint(4) DEFAULT 1 COMMENT 'Is this account tax-deductible?',
  `is_tax` tinyint(4) DEFAULT 0 COMMENT 'Is this account for taxes?',
  `tax_rate` decimal(10,8) DEFAULT NULL COMMENT 'The percentage of the total_amount that is due for this tax.',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this a predefined system object?',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Is this account the default one (or default tax one) for its financial_account_type?',
  `opening_balance` decimal(20,2) DEFAULT 0.00 COMMENT 'Contains the opening balance for this financial account',
  `current_period_opening_balance` decimal(20,2) DEFAULT 0.00 COMMENT 'Contains the opening balance for the current period for this financial account',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`),
  KEY `FK_civicrm_financial_account_parent_id` (`parent_id`),
  KEY `FK_civicrm_financial_account_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_financial_item`;

CREATE TABLE `civicrm_financial_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date and time the item was created',
  `transaction_date` datetime NOT NULL COMMENT 'Date and time of the source transaction',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID of contact the item is from',
  `description` varchar(255) DEFAULT NULL COMMENT 'Human readable description of this item, to ease display without lookup of source item.',
  `amount` decimal(20,2) NOT NULL DEFAULT 0.00 COMMENT 'Total amount of this item',
  `currency` varchar(3) DEFAULT NULL COMMENT 'Currency for the amount',
  `financial_account_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_financial_account',
  `status_id` int(10) unsigned DEFAULT NULL COMMENT 'Payment status: test, paid, part_paid, unpaid (if empty assume unpaid)',
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'The table providing the source of this item such as civicrm_line_item',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'The specific source item that is responsible for the creation of this financial_item',
  PRIMARY KEY (`id`),
  KEY `IX_created_date` (`created_date`),
  KEY `IX_transaction_date` (`transaction_date`),
  KEY `FK_civicrm_financial_item_financial_account_id` (`financial_account_id`),
  KEY `FK_civicrm_financial_item_contact_id` (`contact_id`),
  KEY `index_entity_id_entity_table` (`entity_id`,`entity_table`)
);

DROP TABLE IF EXISTS `civicrm_financial_trxn`;

CREATE TABLE `civicrm_financial_trxn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Gift ID',
  `from_financial_account_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to financial_account table.',
  `to_financial_account_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to financial_financial_account table.',
  `trxn_date` datetime DEFAULT NULL,
  `total_amount` decimal(20,2) NOT NULL COMMENT 'amount of transaction',
  `fee_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual processor fee if known - may be 0.',
  `net_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual funds transfer amount. total less fees. if processor does not report actual fee during transaction, this is set to total_amount.',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `trxn_id` varchar(255) DEFAULT NULL,
  `trxn_result_code` varchar(255) DEFAULT NULL COMMENT 'processor result code',
  `status_id` int(10) unsigned DEFAULT NULL,
  `payment_instrument_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to payment_instrument option group values',
  `check_number` varchar(255) DEFAULT NULL,
  `payment_processor_id` int(10) unsigned DEFAULT NULL COMMENT 'Payment Processor for this contribution Page',
  `is_payment` tinyint(4) DEFAULT 0 COMMENT 'Is this entry either a payment or a reversal of a payment?',
  PRIMARY KEY (`id`),
  KEY `UI_ftrxn_check_number` (`check_number`),
  KEY `UI_ftrxn_payment_instrument_id` (`payment_instrument_id`),
  KEY `FK_civicrm_financial_trxn_to_financial_account_id` (`to_financial_account_id`),
  KEY `FK_civicrm_financial_trxn_from_financial_account_id` (`from_financial_account_id`),
  KEY `FK_civicrm_financial_trxn_payment_processor_id` (`payment_processor_id`),
  KEY `index_trxn_id` (`trxn_id`)
);

DROP TABLE IF EXISTS `civicrm_financial_type`;

CREATE TABLE `civicrm_financial_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution Type ID',
  `name` varchar(64) NOT NULL COMMENT 'Financial Type Name.',
  `description` varchar(255) DEFAULT NULL COMMENT 'Contribution Type Description.',
  `is_deductible` tinyint(4) DEFAULT 1 COMMENT 'Is this contribution type tax-deductible? If true, contributions of this type may be fully OR partially deductible - non-deductible amount is stored in the Contribution record.',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this a predefined system object?',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_id` (`id`)
);

DROP TABLE IF EXISTS `civicrm_grant`;

CREATE TABLE `civicrm_grant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Grant id',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Contact ID of contact record given grant belongs to.',
  `application_received_date` date DEFAULT NULL COMMENT 'Date on which grant application was received by donor.',
  `decision_date` date DEFAULT NULL COMMENT 'Date on which grant decision was made.',
  `money_transfer_date` date DEFAULT NULL COMMENT 'Date on which grant money transfer was made.',
  `grant_due_date` date DEFAULT NULL COMMENT 'Date on which grant report is due.',
  `grant_report_received` tinyint(4) DEFAULT NULL COMMENT 'Yes/No field stating whether grant report was received by donor.',
  `grant_type_id` int(10) unsigned NOT NULL COMMENT 'Type of grant. Implicit FK to civicrm_option_value in grant_type option_group.',
  `amount_total` decimal(20,2) NOT NULL COMMENT 'Requested grant amount, in default currency.',
  `amount_requested` decimal(20,2) DEFAULT NULL COMMENT 'Requested grant amount, in original currency (optional).',
  `amount_granted` decimal(20,2) DEFAULT NULL COMMENT 'Granted amount, in default currency.',
  `currency` varchar(8) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `rationale` text DEFAULT NULL COMMENT 'Grant rationale.',
  `status_id` int(10) unsigned NOT NULL COMMENT 'Id of Grant status.',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Financial Type.',
  PRIMARY KEY (`id`),
  KEY `index_grant_type_id` (`grant_type_id`),
  KEY `index_status_id` (`status_id`),
  KEY `FK_civicrm_grant_contact_id` (`contact_id`),
  KEY `FK_civicrm_grant_financial_type_id` (`financial_type_id`)
);

DROP TABLE IF EXISTS `civicrm_group`;

CREATE TABLE `civicrm_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Internal name of Group.',
  `title` varchar(64) DEFAULT NULL COMMENT 'Name of Group.',
  `description` text DEFAULT NULL COMMENT 'Optional verbose description of the group.',
  `source` varchar(64) DEFAULT NULL COMMENT 'Module or process which created this group.',
  `saved_search_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to saved search table.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this entry active?',
  `visibility` varchar(24) DEFAULT 'User and User Admin Only' COMMENT 'In what context(s) is this field visible.',
  `where_clause` text DEFAULT NULL COMMENT 'the sql where clause if a saved search acl',
  `select_tables` text DEFAULT NULL COMMENT 'the tables to be included in a select data',
  `where_tables` text DEFAULT NULL COMMENT 'the tables to be included in the count statement',
  `group_type` varchar(128) DEFAULT NULL COMMENT 'FK to group type',
  `cache_date` timestamp NULL DEFAULT NULL,
  `refresh_date` timestamp NULL DEFAULT NULL,
  `parents` text DEFAULT NULL COMMENT 'IDs of the parent(s)',
  `children` text DEFAULT NULL COMMENT 'IDs of the child(ren)',
  `is_hidden` tinyint(4) DEFAULT 0 COMMENT 'Is this group hidden?',
  `is_reserved` tinyint(4) DEFAULT 0,
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contact table, creator of the group.',
  `modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contact table, modifier of the group.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_title` (`title`),
  UNIQUE KEY `UI_name` (`name`),
  KEY `index_group_type` (`group_type`),
  KEY `FK_civicrm_group_saved_search_id` (`saved_search_id`),
  KEY `FK_civicrm_group_created_id` (`created_id`),
  KEY `FK_civicrm_group_modified_id` (`modified_id`)
);

DROP TABLE IF EXISTS `civicrm_group_contact`;

CREATE TABLE `civicrm_group_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `group_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_group',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contact',
  `status` varchar(8) DEFAULT NULL COMMENT 'status of contact relative to membership in group',
  `location_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional location to associate with this membership',
  `email_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional email to associate with this membership',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contact_group` (`contact_id`,`group_id`),
  KEY `FK_civicrm_group_contact_group_id` (`group_id`),
  KEY `FK_civicrm_group_contact_location_id` (`location_id`),
  KEY `FK_civicrm_group_contact_email_id` (`email_id`)
);

DROP TABLE IF EXISTS `civicrm_group_contact_cache`;

CREATE TABLE `civicrm_group_contact_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `group_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_group',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contact',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contact_group` (`contact_id`,`group_id`),
  KEY `FK_civicrm_group_contact_cache_group_id` (`group_id`)
);

DROP TABLE IF EXISTS `civicrm_group_nesting`;

CREATE TABLE `civicrm_group_nesting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Relationship ID',
  `child_group_id` int(10) unsigned NOT NULL COMMENT 'ID of the child group',
  `parent_group_id` int(10) unsigned NOT NULL COMMENT 'ID of the parent group',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_group_nesting_child_group_id` (`child_group_id`),
  KEY `FK_civicrm_group_nesting_parent_group_id` (`parent_group_id`)
);

DROP TABLE IF EXISTS `civicrm_group_organization`;

CREATE TABLE `civicrm_group_organization` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Relationship ID',
  `group_id` int(10) unsigned NOT NULL COMMENT 'ID of the group',
  `organization_id` int(10) unsigned NOT NULL COMMENT 'ID of the Organization Contact',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_group_organization` (`group_id`,`organization_id`),
  KEY `FK_civicrm_group_organization_organization_id` (`organization_id`)
);

DROP TABLE IF EXISTS `civicrm_im`;

CREATE TABLE `civicrm_im` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique IM ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this email belong to.',
  `name` varchar(64) DEFAULT NULL COMMENT 'IM screen name',
  `provider_id` int(10) unsigned DEFAULT NULL COMMENT 'Which IM Provider does this screen name belong to.',
  `is_primary` tinyint(4) DEFAULT 0 COMMENT 'Is this the primary IM for this contact and location.',
  `is_billing` tinyint(4) DEFAULT 0 COMMENT 'Is this the billing?',
  PRIMARY KEY (`id`),
  KEY `index_location_type` (`location_type_id`),
  KEY `UI_provider_id` (`provider_id`),
  KEY `index_is_primary` (`is_primary`),
  KEY `index_is_billing` (`is_billing`),
  KEY `FK_civicrm_im_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_job`;

CREATE TABLE `civicrm_job` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Job Id',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this scheduled job for',
  `run_frequency` varchar(8) DEFAULT 'Daily' COMMENT 'Scheduled job run frequency.',
  `last_run` datetime DEFAULT NULL COMMENT 'When was this cron entry last run',
  `scheduled_run_date` timestamp NULL DEFAULT NULL COMMENT 'When is this cron entry scheduled to run',
  `name` varchar(255) DEFAULT NULL COMMENT 'Title of the job',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of the job',
  `api_entity` varchar(255) DEFAULT NULL COMMENT 'Entity of the job api call',
  `api_action` varchar(255) DEFAULT NULL COMMENT 'Action of the job api call',
  `parameters` text DEFAULT NULL COMMENT 'List of parameters to the command.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this job active?',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_job_domain_id` (`domain_id`)
 );

DROP TABLE IF EXISTS `civicrm_job_log`;

CREATE TABLE `civicrm_job_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Job log entry Id',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this scheduled job for',
  `run_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Log entry date',
  `job_id` int(10) unsigned DEFAULT NULL COMMENT 'Pointer to job id - not a FK though, just for logging purposes',
  `name` varchar(255) DEFAULT NULL COMMENT 'Title of the job',
  `command` varchar(255) DEFAULT NULL COMMENT 'Full path to file containing job script',
  `description` varchar(255) DEFAULT NULL COMMENT 'Title line of log entry',
  `data` text DEFAULT NULL COMMENT 'Potential extended data for specific job run (e.g. tracebacks).',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_job_log_domain_id` (`domain_id`)
);

DROP TABLE IF EXISTS `civicrm_line_item`;

CREATE TABLE `civicrm_line_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Line Item',
  `entity_table` varchar(64) NOT NULL COMMENT 'table which has the transaction',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'entry in table',
  `contribution_id` int(10) unsigned DEFAULT NULL COMMENT 'Contribution ID',
  `price_field_id` int(10) unsigned DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL COMMENT 'descriptive label for item - from price_field_value.label',
  `qty` decimal(20,2) DEFAULT NULL,
  `unit_price` decimal(20,2) NOT NULL COMMENT 'price of each item',
  `line_total` decimal(20,2) NOT NULL COMMENT 'qty * unit_price',
  `participant_count` int(10) unsigned DEFAULT NULL COMMENT 'Participant count for field',
  `price_field_value_id` int(10) unsigned DEFAULT NULL COMMENT 'Implicit FK to civicrm_option_value',
  `non_deductible_amount` decimal(20,2) NOT NULL DEFAULT 0.00 COMMENT 'Portion of total amount which is NOT tax deductible.',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Financial Type.',
  `tax_amount` decimal(20,2) DEFAULT NULL COMMENT 'tax of each item',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_line_item_value` (`entity_table`,`entity_id`,`contribution_id`,`price_field_value_id`,`price_field_id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_line_item_price_field_value_id` (`price_field_value_id`),
  KEY `FK_civicrm_line_item_price_field_id` (`price_field_id`),
  KEY `FK_civicrm_line_item_financial_type_id` (`financial_type_id`),
  KEY `FK_civicrm_contribution_id` (`contribution_id`)
);

DROP TABLE IF EXISTS `civicrm_loc_block`;

CREATE TABLE `civicrm_loc_block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique ID',
  `address_id` int(10) unsigned DEFAULT NULL,
  `email_id` int(10) unsigned DEFAULT NULL,
  `phone_id` int(10) unsigned DEFAULT NULL,
  `im_id` int(10) unsigned DEFAULT NULL,
  `address_2_id` int(10) unsigned DEFAULT NULL,
  `email_2_id` int(10) unsigned DEFAULT NULL,
  `phone_2_id` int(10) unsigned DEFAULT NULL,
  `im_2_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_loc_block_address_id` (`address_id`),
  KEY `FK_civicrm_loc_block_email_id` (`email_id`),
  KEY `FK_civicrm_loc_block_phone_id` (`phone_id`),
  KEY `FK_civicrm_loc_block_im_id` (`im_id`),
  KEY `FK_civicrm_loc_block_address_2_id` (`address_2_id`),
  KEY `FK_civicrm_loc_block_email_2_id` (`email_2_id`),
  KEY `FK_civicrm_loc_block_phone_2_id` (`phone_2_id`),
  KEY `FK_civicrm_loc_block_im_2_id` (`im_2_id`)
);

DROP TABLE IF EXISTS `civicrm_location_type`;

CREATE TABLE `civicrm_location_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Location Type ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Location Type Name.',
  `display_name` varchar(64) DEFAULT NULL COMMENT 'Location Type Display Name.',
  `vcard_name` varchar(64) DEFAULT NULL COMMENT 'vCard Location Type Name.',
  `description` varchar(255) DEFAULT NULL COMMENT 'Location Type Description.',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this location type a predefined system location?',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Is this location type the default?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`)
);

DROP TABLE IF EXISTS `civicrm_log`;

CREATE TABLE `civicrm_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `entity_table` varchar(64) NOT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the referenced item.',
  `data` text DEFAULT NULL COMMENT 'Updates does to this object if any.',
  `modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID of person under whose credentials this data modification was made.',
  `modified_date` datetime DEFAULT NULL COMMENT 'When was the referenced entity created or modified or deleted.',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_log_modified_id` (`modified_id`),
  KEY `civicrm_log_entity_id_IDX` (`entity_id`,`entity_table`,`modified_date`) USING BTREE
);

DROP TABLE IF EXISTS `civicrm_mail_settings`;

CREATE TABLE `civicrm_mail_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this match entry for',
  `name` varchar(255) DEFAULT NULL COMMENT 'name of this group of settings',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'whether this is the default set of settings for this domain',
  `domain` varchar(255) DEFAULT NULL COMMENT 'email address domain (the part after @)',
  `localpart` varchar(255) DEFAULT NULL COMMENT 'optional local part (like civimail+ for addresses like civimail+s.1.2@example.com)',
  `return_path` varchar(255) DEFAULT NULL COMMENT 'contents of the Return-Path header',
  `protocol` varchar(255) DEFAULT NULL COMMENT 'name of the protocol to use for polling (like IMAP, POP3 or Maildir)',
  `server` varchar(255) DEFAULT NULL COMMENT 'server to use when polling',
  `port` int(10) unsigned DEFAULT NULL COMMENT 'port to use when polling',
  `username` varchar(255) DEFAULT NULL COMMENT 'username to use when polling',
  `password` varchar(255) DEFAULT NULL COMMENT 'password to use when polling',
  `is_ssl` tinyint(4) DEFAULT NULL COMMENT 'whether to use SSL or not',
  `source` varchar(255) DEFAULT NULL COMMENT 'folder to poll from when using IMAP, path to poll from when using Maildir, etc.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mail_settings_domain_id` (`domain_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing`;

CREATE TABLE `civicrm_mailing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned DEFAULT NULL COMMENT 'Which site is this mailing for',
  `header_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the header component.',
  `footer_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the footer component.',
  `reply_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the auto-responder component.',
  `unsubscribe_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the unsubscribe component.',
  `resubscribe_id` int(10) unsigned DEFAULT NULL,
  `optout_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the opt-out component.',
  `name` varchar(128) DEFAULT NULL COMMENT 'Mailing Name.',
  `from_name` varchar(128) DEFAULT NULL COMMENT 'From Header of mailing',
  `from_email` varchar(128) DEFAULT NULL COMMENT 'From Email of mailing',
  `replyto_email` varchar(128) DEFAULT NULL COMMENT 'Reply-To Email of mailing',
  `subject` varchar(128) DEFAULT NULL COMMENT 'Subject of mailing',
  `body_text` longtext DEFAULT NULL COMMENT 'Body of the mailing in text format.',
  `body_html` longtext DEFAULT NULL COMMENT 'Body of the mailing in html format.',
  `url_tracking` tinyint(4) DEFAULT NULL COMMENT 'Should we track URL click-throughs for this mailing?',
  `forward_replies` tinyint(4) DEFAULT NULL COMMENT 'Should we forward replies back to the author?',
  `auto_responder` tinyint(4) DEFAULT NULL COMMENT 'Should we enable the auto-responder?',
  `open_tracking` tinyint(4) DEFAULT NULL COMMENT 'Should we track when recipients open/read this mailing?',
  `is_completed` tinyint(4) DEFAULT NULL COMMENT 'Has at least one job associated with this mailing finished?',
  `msg_template_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the message template.',
  `override_verp` tinyint(4) DEFAULT 0 COMMENT 'Should we overrite VERP address in Reply-To',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID who first created this mailing',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time this mailing was created.',
  `scheduled_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID who scheduled this mailing',
  `scheduled_date` datetime DEFAULT NULL COMMENT 'Date and time this mailing was scheduled.',
  `approver_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID who approved this mailing',
  `approval_date` datetime DEFAULT NULL COMMENT 'Date and time this mailing was approved.',
  `approval_status_id` int(10) unsigned DEFAULT NULL COMMENT 'The status of this mailing. Values: none, approved, rejected',
  `approval_note` longtext DEFAULT NULL COMMENT 'Note behind the decision.',
  `is_archived` tinyint(4) DEFAULT 0 COMMENT 'Is this mailing archived?',
  `visibility` varchar(40) DEFAULT 'User and User Admin Only' COMMENT 'In what context(s) is the mailing contents visible (online viewing)',
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'The campaign for which this mailing has been initiated.',
  `dedupe_email` tinyint(4) DEFAULT 0 COMMENT 'Remove duplicate emails?',
  `sms_provider_id` int(10) unsigned DEFAULT NULL,
  `hash` varchar(16) DEFAULT NULL COMMENT 'Key for validating requests related to this mailing.',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'With email_selection_method, determines which email address to use',
  `email_selection_method` varchar(20) DEFAULT 'automatic' COMMENT 'With location_type_id, determine how to choose the email address to use.',
  `mailing_type` varchar(32) DEFAULT NULL COMMENT 'differentiate between standalone mailings, A/B tests, and A/B final-winner',
  `language` varchar(5) DEFAULT NULL COMMENT 'Language of the content of the mailing. Useful for tokens.',
  `template_type` varchar(64) NOT NULL DEFAULT 'traditional' COMMENT 'The language/processing system used for email templates.',
  `template_options` longtext DEFAULT NULL COMMENT 'Advanced options used by the email templating system. (JSON encoded)',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_domain_id` (`domain_id`),
  KEY `FK_civicrm_mailing_header_id` (`header_id`),
  KEY `FK_civicrm_mailing_footer_id` (`footer_id`),
  KEY `FK_civicrm_mailing_reply_id` (`reply_id`),
  KEY `FK_civicrm_mailing_unsubscribe_id` (`unsubscribe_id`),
  KEY `FK_civicrm_mailing_optout_id` (`optout_id`),
  KEY `FK_civicrm_mailing_msg_template_id` (`msg_template_id`),
  KEY `FK_civicrm_mailing_created_id` (`created_id`),
  KEY `FK_civicrm_mailing_scheduled_id` (`scheduled_id`),
  KEY `FK_civicrm_mailing_approver_id` (`approver_id`),
  KEY `FK_civicrm_mailing_campaign_id` (`campaign_id`),
  KEY `FK_civicrm_mailing_sms_provider_id` (`sms_provider_id`),
  KEY `index_hash` (`hash`),
  KEY `FK_civicrm_mailing_location_type_id` (`location_type_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_abtest`;

CREATE TABLE `civicrm_mailing_abtest` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL COMMENT 'Name of the A/B test',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `mailing_id_a` int(10) unsigned DEFAULT NULL COMMENT 'The first experimental mailing ("A" condition)',
  `mailing_id_b` int(10) unsigned DEFAULT NULL COMMENT 'The second experimental mailing ("B" condition)',
  `mailing_id_c` int(10) unsigned DEFAULT NULL COMMENT 'The final, general mailing (derived from A or B)',
  `domain_id` int(10) unsigned DEFAULT NULL COMMENT 'Which site is this mailing for',
  `specific_url` varchar(255) DEFAULT NULL COMMENT 'What specific url to track',
  `declare_winning_time` datetime DEFAULT NULL COMMENT 'In how much time to declare winner',
  `group_percentage` int(10) unsigned DEFAULT NULL,
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `created_date` datetime DEFAULT NULL COMMENT 'When was this item created',
  `testing_criteria` varchar(32) DEFAULT NULL,
  `winner_criteria` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_abtest_created_id` (`created_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_bounce_pattern`;

CREATE TABLE `civicrm_mailing_bounce_pattern` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bounce_type_id` int(10) unsigned NOT NULL COMMENT 'Type of bounce',
  `pattern` varchar(255) DEFAULT NULL COMMENT 'A regexp to match a message to a bounce type',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_bounce_pattern_bounce_type_id` (`bounce_type_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_bounce_type`;

CREATE TABLE `civicrm_mailing_bounce_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(24) NOT NULL COMMENT 'Type of bounce',
  `description` varchar(255) DEFAULT NULL COMMENT 'A description of this bounce type',
  `hold_threshold` int(10) unsigned NOT NULL COMMENT 'Number of bounces of this type required before the email address is put on bounce hold',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_component`;

CREATE TABLE `civicrm_mailing_component` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT 'The name of this component',
  `component_type` varchar(12) DEFAULT NULL COMMENT 'Type of Component.',
  `subject` varchar(255) DEFAULT NULL,
  `body_html` text DEFAULT NULL COMMENT 'Body of the component in html format.',
  `body_text` text DEFAULT NULL COMMENT 'Body of the component in text format.',
  `is_default` tinyint(4) DEFAULT 0 COMMENT 'Is this the default component for this component_type?',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this property active?',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_bounce`;

CREATE TABLE `civicrm_mailing_event_bounce` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `bounce_type_id` int(10) unsigned DEFAULT NULL COMMENT 'What type of bounce was it?',
  `bounce_reason` varchar(255) DEFAULT NULL COMMENT 'The reason the email bounced.',
  `time_stamp` datetime NOT NULL COMMENT 'When this bounce event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_bounce_event_queue_id` (`event_queue_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_confirm`;

CREATE TABLE `civicrm_mailing_event_confirm` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_subscribe_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_mailing_event_subscribe',
  `time_stamp` datetime NOT NULL COMMENT 'When this confirmation event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_confirm_event_subscribe_id` (`event_subscribe_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_delivered`;

CREATE TABLE `civicrm_mailing_event_delivered` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `time_stamp` datetime NOT NULL COMMENT 'When this delivery event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_delivered_event_queue_id` (`event_queue_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_forward`;

CREATE TABLE `civicrm_mailing_event_forward` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `dest_queue_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to EventQueue for destination',
  `time_stamp` datetime NOT NULL COMMENT 'When this forward event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_forward_event_queue_id` (`event_queue_id`),
  KEY `FK_civicrm_mailing_event_forward_dest_queue_id` (`dest_queue_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_opened`;

CREATE TABLE `civicrm_mailing_event_opened` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `time_stamp` datetime NOT NULL COMMENT 'When this open event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_opened_event_queue_id` (`event_queue_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_queue`;

CREATE TABLE `civicrm_mailing_event_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` int(10) unsigned NOT NULL COMMENT 'FK to Job',
  `email_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Email',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact',
  `hash` varchar(255) NOT NULL COMMENT 'Security hash',
  `phone_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Phone',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_queue_job_id` (`job_id`),
  KEY `FK_civicrm_mailing_event_queue_email_id` (`email_id`),
  KEY `FK_civicrm_mailing_event_queue_contact_id` (`contact_id`),
  KEY `FK_civicrm_mailing_event_queue_phone_id` (`phone_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_reply`;

CREATE TABLE `civicrm_mailing_event_reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `time_stamp` datetime NOT NULL COMMENT 'When this reply event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_reply_event_queue_id` (`event_queue_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_subscribe`;

CREATE TABLE `civicrm_mailing_event_subscribe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL COMMENT 'FK to Group',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact',
  `hash` varchar(255) NOT NULL COMMENT 'Security hash',
  `time_stamp` datetime NOT NULL COMMENT 'When this subscription event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_subscribe_group_id` (`group_id`),
  KEY `FK_civicrm_mailing_event_subscribe_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_trackable_url_open`;

CREATE TABLE `civicrm_mailing_event_trackable_url_open` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `trackable_url_id` int(10) unsigned NOT NULL COMMENT 'FK to TrackableURL',
  `time_stamp` datetime NOT NULL COMMENT 'When this trackable URL open occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_trackable_url_open_event_queue_id` (`event_queue_id`),
  KEY `FK_civicrm_mailing_event_trackable_url_open_trackable_url_id` (`trackable_url_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_event_unsubscribe`;

CREATE TABLE `civicrm_mailing_event_unsubscribe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_queue_id` int(10) unsigned NOT NULL COMMENT 'FK to EventQueue',
  `org_unsubscribe` tinyint(4) NOT NULL COMMENT 'Unsubscribe at org- or group-level',
  `time_stamp` datetime NOT NULL COMMENT 'When this delivery event occurred.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_event_unsubscribe_event_queue_id` (`event_queue_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_group`;

CREATE TABLE `civicrm_mailing_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mailing_id` int(10) unsigned NOT NULL COMMENT 'The ID of a previous mailing to include/exclude recipients.',
  `group_type` varchar(8) DEFAULT NULL COMMENT 'Are the members of the group included or excluded?.',
  `entity_table` varchar(64) NOT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the referenced item.',
  `search_id` int(11) DEFAULT NULL COMMENT 'The filtering search. custom search id or -1 for civicrm api search',
  `search_args` text DEFAULT NULL COMMENT 'The arguments to be sent to the search function',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_group_mailing_id` (`mailing_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_job`;

CREATE TABLE `civicrm_mailing_job` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mailing_id` int(10) unsigned NOT NULL COMMENT 'The ID of the mailing this Job will send.',
  `scheduled_date` datetime DEFAULT NULL COMMENT 'date on which this job was scheduled.',
  `start_date` datetime DEFAULT NULL COMMENT 'date on which this job was started.',
  `end_date` datetime DEFAULT NULL COMMENT 'date on which this job ended.',
  `status` varchar(12) DEFAULT NULL COMMENT 'The state of this job',
  `is_test` tinyint(4) DEFAULT 0 COMMENT 'Is this job for a test mail?',
  `job_type` varchar(255) DEFAULT NULL COMMENT 'Type of mailling job: null | child ',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent job id',
  `job_offset` int(11) DEFAULT 0 COMMENT 'Offset of the child job',
  `job_limit` int(11) DEFAULT 0 COMMENT 'Queue size limit for each child job',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_job_mailing_id` (`mailing_id`),
  KEY `FK_civicrm_mailing_job_parent_id` (`parent_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_recipients`;

CREATE TABLE `civicrm_mailing_recipients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mailing_id` int(10) unsigned NOT NULL COMMENT 'The ID of the mailing this Job will send.',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact',
  `email_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Email',
  `phone_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Phone',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_recipients_mailing_id` (`mailing_id`),
  KEY `FK_civicrm_mailing_recipients_contact_id` (`contact_id`),
  KEY `FK_civicrm_mailing_recipients_email_id` (`email_id`),
  KEY `FK_civicrm_mailing_recipients_phone_id` (`phone_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_spool`;

CREATE TABLE `civicrm_mailing_spool` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` int(10) unsigned NOT NULL COMMENT 'The ID of the Job .',
  `recipient_email` text DEFAULT NULL COMMENT 'The email of the receipients this mail is to be sent.',
  `headers` text DEFAULT NULL COMMENT 'The header information of this mailing .',
  `body` text DEFAULT NULL COMMENT 'The body of this mailing.',
  `added_at` datetime DEFAULT NULL COMMENT 'date on which this job was added.',
  `removed_at` datetime DEFAULT NULL COMMENT 'date on which this job was removed.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_spool_job_id` (`job_id`)
);

DROP TABLE IF EXISTS `civicrm_mailing_trackable_url`;

CREATE TABLE `civicrm_mailing_trackable_url` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` text NOT NULL COMMENT 'The URL to be tracked.',
  `mailing_id` int(10) unsigned NOT NULL COMMENT 'FK to the mailing',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mailing_trackable_url_mailing_id` (`mailing_id`)
);

DROP TABLE IF EXISTS `civicrm_managed`;

CREATE TABLE `civicrm_managed` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Surrogate Key',
  `module` varchar(127) NOT NULL COMMENT 'Name of the module which declared this object',
  `name` varchar(127) DEFAULT NULL COMMENT 'Symbolic name used by the module to identify the object',
  `entity_type` varchar(64) NOT NULL COMMENT 'API entity type',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the referenced item.',
  `cleanup` varchar(32) DEFAULT NULL COMMENT 'Policy on when to cleanup entity (always, never, unused)',
  PRIMARY KEY (`id`),
  KEY `UI_managed_module_name` (`module`,`name`),
  KEY `UI_managed_entity` (`entity_type`,`entity_id`)
);

DROP TABLE IF EXISTS `civicrm_mapping`;

CREATE TABLE `civicrm_mapping` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Mapping ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Name of Mapping',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of Mapping.',
  `mapping_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Mapping Type',
  PRIMARY KEY (`id`),
  KEY `UI_name` (`name`)
);

DROP TABLE IF EXISTS `civicrm_mapping_field`;

CREATE TABLE `civicrm_mapping_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Mapping Field ID',
  `mapping_id` int(10) unsigned NOT NULL COMMENT 'Mapping to which this field belongs',
  `name` varchar(255) DEFAULT NULL COMMENT 'Mapping field key',
  `contact_type` varchar(64) DEFAULT NULL COMMENT 'Contact Type in mapping',
  `column_number` int(10) unsigned NOT NULL COMMENT 'Column number for mapping set',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Location type of this mapping, if required',
  `phone_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which type of phone does this number belongs.',
  `im_provider_id` int(10) unsigned DEFAULT NULL COMMENT 'Which type of IM Provider does this name belong.',
  `website_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which type of website does this site belong',
  `relationship_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Relationship type, if required',
  `relationship_direction` varchar(6) DEFAULT NULL,
  `grouping` int(10) unsigned DEFAULT 1 COMMENT 'Used to group mapping_field records into related sets (e.g. for criteria sets in search builder mappings).',
  `operator` varchar(16) DEFAULT NULL COMMENT 'SQL WHERE operator for search-builder mapping fields (search criteria).',
  `value` varchar(255) DEFAULT NULL COMMENT 'SQL WHERE value for search-builder mapping fields.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_mapping_field_mapping_id` (`mapping_id`),
  KEY `FK_civicrm_mapping_field_location_type_id` (`location_type_id`),
  KEY `FK_civicrm_mapping_field_relationship_type_id` (`relationship_type_id`)
);

DROP TABLE IF EXISTS `civicrm_membership`;

CREATE TABLE `civicrm_membership` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Membership Id',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID',
  `membership_type_id` int(10) unsigned NOT NULL COMMENT 'FK to Membership Type',
  `join_date` date DEFAULT NULL COMMENT 'Beginning of initial membership period (member since...).',
  `start_date` date DEFAULT NULL COMMENT 'Beginning of current uninterrupted membership period.',
  `end_date` date DEFAULT NULL COMMENT 'Current membership period expire date.',
  `source` varchar(128) DEFAULT NULL,
  `status_id` int(10) unsigned NOT NULL COMMENT 'FK to Membership Status',
  `is_override` tinyint(4) DEFAULT NULL COMMENT 'Admin users may set a manual status which overrides the calculated status. When this flag is true, automated status update scripts should NOT modify status for the record.',
  `owner_membership_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional FK to Parent Membership.',
  `max_related` int(10) unsigned DEFAULT NULL COMMENT 'Maximum number of related memberships (membership_type override).',
  `is_test` tinyint(4) DEFAULT 0,
  `is_pay_later` tinyint(4) DEFAULT 0,
  `contribution_recur_id` int(10) unsigned DEFAULT NULL COMMENT 'Conditional foreign key to civicrm_contribution_recur id. Each membership in connection with a recurring contribution carries a foreign key to the recurring contribution record. This assumes we can track these processor initiated events.',
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'The campaign for which this membership is attached.',
  PRIMARY KEY (`id`),
  KEY `index_owner_membership_id` (`owner_membership_id`),
  KEY `FK_civicrm_membership_contact_id` (`contact_id`),
  KEY `FK_civicrm_membership_membership_type_id` (`membership_type_id`),
  KEY `FK_civicrm_membership_status_id` (`status_id`),
  KEY `FK_civicrm_membership_contribution_recur_id` (`contribution_recur_id`),
  KEY `FK_civicrm_membership_campaign_id` (`campaign_id`)
);

DROP TABLE IF EXISTS `civicrm_membership_block`;

CREATE TABLE `civicrm_membership_block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Membership Id',
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'Name for Membership Status',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contribution_page.id',
  `membership_types` varchar(1024) DEFAULT NULL COMMENT 'Membership types to be exposed by this block.',
  `membership_type_default` int(10) unsigned DEFAULT NULL COMMENT 'Optional foreign key to membership_type',
  `display_min_fee` tinyint(4) DEFAULT 1 COMMENT 'Display minimum membership fee',
  `is_separate_payment` tinyint(4) DEFAULT 1 COMMENT 'Should membership transactions be processed separately',
  `new_title` varchar(255) DEFAULT NULL COMMENT 'Title to display at top of block',
  `new_text` text DEFAULT NULL COMMENT 'Text to display below title',
  `renewal_title` varchar(255) DEFAULT NULL COMMENT 'Title for renewal',
  `renewal_text` text DEFAULT NULL COMMENT 'Text to display for member renewal',
  `is_required` tinyint(4) DEFAULT 0 COMMENT 'Is membership sign up optional',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this membership_block enabled',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_membership_block_entity_id` (`entity_id`),
  KEY `FK_civicrm_membership_block_membership_type_default` (`membership_type_default`)
);

DROP TABLE IF EXISTS `civicrm_membership_log`;

CREATE TABLE `civicrm_membership_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `membership_id` int(10) unsigned NOT NULL COMMENT 'FK to Membership table',
  `status_id` int(10) unsigned NOT NULL COMMENT 'New status assigned to membership by this action. FK to Membership Status',
  `start_date` date DEFAULT NULL COMMENT 'New membership period start date',
  `end_date` date DEFAULT NULL COMMENT 'New membership period expiration date.',
  `modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID of person under whose credentials this data modification was made.',
  `modified_date` date DEFAULT NULL COMMENT 'Date this membership modification action was logged.',
  `membership_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Membership Type.',
  `max_related` int(10) unsigned DEFAULT NULL COMMENT 'Maximum number of related memberships.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_membership_log_membership_id` (`membership_id`),
  KEY `FK_civicrm_membership_log_status_id` (`status_id`),
  KEY `FK_civicrm_membership_log_modified_id` (`modified_id`),
  KEY `FK_civicrm_membership_log_membership_type_id` (`membership_type_id`)
);

DROP TABLE IF EXISTS `civicrm_membership_payment`;

CREATE TABLE `civicrm_membership_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `membership_id` int(10) unsigned NOT NULL COMMENT 'FK to Membership table',
  `contribution_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contribution table.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contribution_membership` (`contribution_id`,`membership_id`),
  KEY `FK_civicrm_membership_payment_membership_id` (`membership_id`)
);

DROP TABLE IF EXISTS `civicrm_membership_status`;

CREATE TABLE `civicrm_membership_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Membership Id',
  `name` varchar(128) DEFAULT NULL COMMENT 'Name for Membership Status',
  `label` varchar(128) DEFAULT NULL COMMENT 'Label for Membership Status',
  `start_event` varchar(12) DEFAULT NULL COMMENT 'Event when this status starts.',
  `start_event_adjust_unit` varchar(8) DEFAULT NULL COMMENT 'Unit used for adjusting from start_event.',
  `start_event_adjust_interval` int(11) DEFAULT NULL COMMENT 'Status range begins this many units from start_event.',
  `end_event` varchar(12) DEFAULT NULL COMMENT 'Event after which this status ends.',
  `end_event_adjust_unit` varchar(8) DEFAULT NULL COMMENT 'Unit used for adjusting from the ending event.',
  `end_event_adjust_interval` int(11) DEFAULT NULL COMMENT 'Status range ends this many units from end_event.',
  `is_current_member` tinyint(4) DEFAULT NULL COMMENT 'Does this status aggregate to current members (e.g. New, Renewed, Grace might all be TRUE... while Unrenewed, Lapsed, Inactive would be FALSE).',
  `is_admin` tinyint(4) DEFAULT NULL COMMENT 'Is this status for admin/manual assignment only.',
  `weight` int(11) DEFAULT NULL,
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Assign this status to a membership record if no other status match is found.',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this membership_status enabled.',
  `is_reserved` tinyint(4) DEFAULT 0 COMMENT 'Is this membership_status reserved.',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_membership_type`;

CREATE TABLE `civicrm_membership_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Membership Id',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this match entry for',
  `name` varchar(128) DEFAULT NULL COMMENT 'Name of Membership Type',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of Membership Type',
  `member_of_contact_id` int(10) unsigned NOT NULL COMMENT 'Owner organization for this membership type. FK to Contact ID',
  `financial_type_id` int(10) unsigned NOT NULL COMMENT 'If membership is paid by a contribution - what financial type should be used. FK to civicrm_financial_type.id',
  `minimum_fee` decimal(20,2) DEFAULT 0.00 COMMENT 'Minimum fee for this membership (0 for free/complimentary memberships).',
  `duration_unit` varchar(8) DEFAULT NULL COMMENT 'Unit in which membership period is expressed.',
  `duration_interval` int(11) DEFAULT NULL COMMENT 'Number of duration units in membership period (e.g. 1 year, 12 months).',
  `period_type` varchar(8) DEFAULT NULL COMMENT 'Rolling membership period starts on signup date. Fixed membership periods start on fixed_period_start_day.',
  `fixed_period_start_day` int(11) DEFAULT NULL COMMENT 'For fixed period memberships, month and day (mmdd) on which subscription/membership will start. Period start is back-dated unless after rollover day.',
  `fixed_period_rollover_day` int(11) DEFAULT NULL COMMENT 'For fixed period memberships, signups after this day (mmdd) rollover to next period.',
  `relationship_type_id` varchar(64) DEFAULT NULL COMMENT 'FK to Relationship Type ID',
  `relationship_direction` varchar(128) DEFAULT NULL,
  `max_related` int(10) unsigned DEFAULT NULL COMMENT 'Maximum number of related memberships.',
  `visibility` varchar(64) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `receipt_text_signup` varchar(255) DEFAULT NULL COMMENT 'Receipt Text for membership signup',
  `receipt_text_renewal` varchar(255) DEFAULT NULL COMMENT 'Receipt Text for membership renewal',
  `auto_renew` tinyint(4) DEFAULT 0 COMMENT '0 = No auto-renew option 1 = Give option, but not required 2 = Auto-renew required',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this membership_type enabled',
  PRIMARY KEY (`id`),
  KEY `index_relationship_type_id` (`relationship_type_id`),
  KEY `FK_civicrm_membership_type_domain_id` (`domain_id`),
  KEY `FK_civicrm_membership_type_member_of_contact_id` (`member_of_contact_id`),
  KEY `FK_civicrm_membership_type_financial_type_id` (`financial_type_id`)
);

DROP TABLE IF EXISTS `civicrm_menu`;

CREATE TABLE `civicrm_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this menu item for',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path Name',
  `path_arguments` text DEFAULT NULL COMMENT 'Arguments to pass to the url',
  `title` varchar(255) DEFAULT NULL COMMENT 'Menu Title',
  `access_callback` varchar(255) DEFAULT NULL COMMENT 'Function to call to check access permissions',
  `access_arguments` text DEFAULT NULL COMMENT 'Arguments to pass to access callback',
  `page_callback` varchar(255) DEFAULT NULL COMMENT 'function to call for this url',
  `page_arguments` text DEFAULT NULL COMMENT 'Arguments to pass to page callback',
  `breadcrumb` text DEFAULT NULL COMMENT 'Breadcrumb for the path.',
  `return_url` varchar(255) DEFAULT NULL COMMENT 'Url where a page should redirected to, if next url not known.',
  `return_url_args` varchar(255) DEFAULT NULL COMMENT 'Arguments to pass to return_url',
  `component_id` int(10) unsigned DEFAULT NULL COMMENT 'Component that this menu item belongs to',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this menu item active?',
  `is_public` tinyint(4) DEFAULT NULL COMMENT 'Is this menu accessible to the public?',
  `is_exposed` tinyint(4) DEFAULT NULL COMMENT 'Is this menu exposed to the navigation system?',
  `is_ssl` tinyint(4) DEFAULT NULL COMMENT 'Should this menu be exposed via SSL if enabled?',
  `weight` int(11) NOT NULL DEFAULT 1 COMMENT 'Ordering of the menu items in various blocks.',
  `type` int(11) NOT NULL DEFAULT 1 COMMENT 'Drupal menu type.',
  `page_type` int(11) NOT NULL DEFAULT 1 COMMENT 'CiviCRM menu type.',
  `skipBreadcrumb` tinyint(4) DEFAULT NULL COMMENT 'skip this url being exposed to breadcrumb',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_path_domain_id` (`path`,`domain_id`),
  KEY `FK_civicrm_menu_domain_id` (`domain_id`),
  KEY `FK_civicrm_menu_component_id` (`component_id`)
);

DROP TABLE IF EXISTS `civicrm_msg_template`;

CREATE TABLE `civicrm_msg_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message Template ID',
  `msg_title` varchar(255) DEFAULT NULL COMMENT 'Descriptive title of message',
  `msg_subject` text DEFAULT NULL COMMENT 'Subject for email message.',
  `msg_text` longtext DEFAULT NULL COMMENT 'Text formatted message',
  `msg_html` longtext DEFAULT NULL COMMENT 'HTML formatted message',
  `is_active` tinyint(4) DEFAULT 1,
  `workflow_id` int(10) unsigned DEFAULT NULL COMMENT 'a pseudo-FK to civicrm_option_value',
  `is_default` tinyint(4) DEFAULT 1 COMMENT 'is this the default message template for the workflow referenced by workflow_id?',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'is this the reserved message template which we ship for the workflow referenced by workflow_id?',
  `pdf_format_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value containing PDF Page Format.',
  `is_sms` tinyint(4) DEFAULT 0 COMMENT 'Is this message template used for sms?',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_navigation`;

CREATE TABLE `civicrm_navigation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this navigation item for',
  `label` varchar(255) DEFAULT NULL COMMENT 'Navigation Title',
  `name` varchar(255) DEFAULT NULL COMMENT 'Internal Name',
  `url` varchar(255) DEFAULT NULL COMMENT 'url in case of custom navigation link',
  `permission` varchar(255) DEFAULT NULL COMMENT 'Permission for menu item',
  `permission_operator` varchar(3) DEFAULT NULL COMMENT 'Permission Operator',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent navigation item, used for grouping',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this navigation item active?',
  `has_separator` tinyint(4) DEFAULT NULL COMMENT 'If separator needs to be added after this menu item',
  `weight` int(11) DEFAULT NULL COMMENT 'Ordering of the navigation items in various blocks.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_navigation_domain_id` (`domain_id`),
  KEY `FK_civicrm_navigation_parent_id` (`parent_id`)
);

DROP TABLE IF EXISTS `civicrm_note`;

CREATE TABLE `civicrm_note` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Note ID',
  `entity_table` varchar(64) NOT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the referenced item.',
  `note` text DEFAULT NULL COMMENT 'Note and/or Comment.',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID creator',
  `modified_date` date DEFAULT NULL COMMENT 'When was this note last modified/edited',
  `subject` varchar(255) DEFAULT NULL COMMENT 'subject of note description',
  `privacy` varchar(255) DEFAULT NULL COMMENT 'Foreign Key to Note Privacy Level (which is an option value pair and hence an implicit FK)',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_note_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_openid`;

CREATE TABLE `civicrm_openid` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique OpenID ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this email belong to.',
  `openid` varchar(255) DEFAULT NULL COMMENT 'the OpenID (or OpenID-style http://username.domain/) unique identifier for this contact mainly used for logging in to CiviCRM',
  `allowed_to_login` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Whether or not this user is allowed to login',
  `is_primary` tinyint(4) DEFAULT 0 COMMENT 'Is this the primary email for this contact and location.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_openid` (`openid`),
  KEY `index_location_type` (`location_type_id`),
  KEY `FK_civicrm_openid_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_option_group`;

CREATE TABLE `civicrm_option_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Group ID',
  `name` varchar(64) NOT NULL COMMENT 'Option group name. Used as selection key by class properties which lookup options in civicrm_option_value.',
  `title` varchar(255) DEFAULT NULL COMMENT 'Option Group title.',
  `description` varchar(255) DEFAULT NULL COMMENT 'Option group description.',
  `is_reserved` tinyint(4) DEFAULT 1 COMMENT 'Is this a predefined system option group (i.e. it can not be deleted)?',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this option group active?',
  `is_locked` int(1) DEFAULT 0 COMMENT 'A lock to remove the ability to add new options via the UI',
  `data_type` varchar(128) DEFAULT NULL COMMENT 'Data Type of Option Group.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`)
);

DROP TABLE IF EXISTS `civicrm_option_value`;

CREATE TABLE `civicrm_option_value` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `option_group_id` int(10) unsigned NOT NULL COMMENT 'Group which this option belongs to.',
  `label` varchar(512) DEFAULT NULL,
  `value` varchar(512) NOT NULL COMMENT 'The actual value stored (as a foreign key) in the data record. Functions which need lookup option_value.title should use civicrm_option_value.option_group_id plus civicrm_option_value.value as the key.',
  `name` varchar(255) DEFAULT NULL COMMENT 'Stores a fixed (non-translated) name for this option value. Lookup functions should use the name as the key for the option value row.',
  `grouping` varchar(255) DEFAULT NULL COMMENT 'Use to sort and/or set display properties for sub-set(s) of options within an option group. EXAMPLE: Use for college_interest field, to differentiate partners from non-partners.',
  `filter` int(10) unsigned DEFAULT NULL COMMENT 'Bitwise logic can be used to create subsets of options within an option_group for different uses.',
  `is_default` tinyint(4) DEFAULT 0 COMMENT 'Is this the default option for the group?',
  `weight` int(10) unsigned NOT NULL COMMENT 'Controls display sort order.',
  `description` text DEFAULT NULL COMMENT 'Optional description.',
  `is_optgroup` tinyint(4) DEFAULT 0 COMMENT 'Is this row simply a display header? Expected usage is to render these as OPTGROUP tags within a SELECT field list of options?',
  `is_reserved` tinyint(4) DEFAULT 0 COMMENT 'Is this a predefined system object?',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this option active?',
  `component_id` int(10) unsigned DEFAULT NULL COMMENT 'Component that this option value belongs/caters to.',
  `domain_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Domain is this option value for',
  `visibility_id` int(10) unsigned DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL COMMENT 'crm-i icon class',
  `color` varchar(255) DEFAULT NULL COMMENT 'Hex color value e.g. #ffffff',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_option_value_component_id` (`component_id`),
  KEY `FK_civicrm_option_value_domain_id` (`domain_id`),
  KEY `index_option_group_id_value` (`value`(128),`option_group_id`),
  KEY `index_option_group_id_name` (`option_group_id`,`name`(128)),
  KEY `civicrm_option_value_option_group_id_IDX` (`option_group_id`) USING BTREE
);

DROP TABLE IF EXISTS `civicrm_participant`;

CREATE TABLE `civicrm_participant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Participant Id',
  `contact_id` int(10) unsigned NOT NULL,
  `event_id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'Participant status ID. FK to civicrm_participant_status_type. Default of 1 should map to status = Registered.',
  `role_id` varchar(128) DEFAULT NULL COMMENT 'Participant role ID. Implicit FK to civicrm_option_value where option_group = participant_role.',
  `register_date` datetime DEFAULT NULL COMMENT 'When did contact register for event?',
  `source` varchar(128) DEFAULT NULL COMMENT 'Source of this event registration.',
  `fee_level` text DEFAULT NULL COMMENT 'Populate with the label (text) associated with a fee level for paid events with multiple levels. Note that we store the label value and not the key',
  `is_test` tinyint(4) DEFAULT 0,
  `is_pay_later` tinyint(4) DEFAULT 0,
  `fee_amount` decimal(20,2) DEFAULT NULL COMMENT 'actual processor fee if known - may be 0.',
  `registered_by_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Participant ID',
  `discount_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Discount ID',
  `fee_currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value derived from config setting.',
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'The campaign for which this participant has been registered.',
  `discount_amount` int(10) unsigned DEFAULT NULL COMMENT 'Discount Amount',
  `cart_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_event_carts',
  `must_wait` int(11) DEFAULT NULL COMMENT 'On Waiting List',
  `transferred_to_contact_id` int(10) unsigned DEFAULT NULL COMMENT 'Contact to which the event registration is transferred',
  PRIMARY KEY (`id`),
  KEY `index_status_id` (`status_id`),
  KEY `index_role_id` (`role_id`),
  KEY `FK_civicrm_participant_contact_id` (`contact_id`),
  KEY `FK_civicrm_participant_event_id` (`event_id`),
  KEY `FK_civicrm_participant_registered_by_id` (`registered_by_id`),
  KEY `FK_civicrm_participant_discount_id` (`discount_id`),
  KEY `FK_civicrm_participant_campaign_id` (`campaign_id`),
  KEY `FK_civicrm_participant_cart_id` (`cart_id`),
  KEY `FK_civicrm_participant_transferred_to_contact_id` (`transferred_to_contact_id`)
);

DROP TABLE IF EXISTS `civicrm_participant_payment`;

CREATE TABLE `civicrm_participant_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Participant Payment Id',
  `participant_id` int(10) unsigned NOT NULL COMMENT 'Participant Id (FK)',
  `contribution_id` int(10) unsigned NOT NULL COMMENT 'FK to contribution table.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_contribution_participant` (`contribution_id`,`participant_id`),
  KEY `FK_civicrm_participant_payment_participant_id` (`participant_id`)
);

DROP TABLE IF EXISTS `civicrm_participant_status_type`;

CREATE TABLE `civicrm_participant_status_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'unique participant status type id',
  `name` varchar(64) DEFAULT NULL COMMENT 'non-localized name of the status type',
  `label` varchar(255) DEFAULT NULL COMMENT 'localized label for display of this status type',
  `class` varchar(8) DEFAULT NULL COMMENT 'the general group of status type this one belongs to',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'whether this is a status type required by the system',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'whether this status type is active',
  `is_counted` tinyint(4) DEFAULT NULL COMMENT 'whether this status type is counted against event size limit',
  `weight` int(10) unsigned NOT NULL COMMENT 'controls sort order',
  `visibility_id` int(10) unsigned DEFAULT NULL COMMENT 'whether the status type is visible to the public, an implicit foreign key to option_value.value related to the `visibility` option_group',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_payment_processor`;

CREATE TABLE `civicrm_payment_processor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Processor ID',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this match entry for',
  `name` varchar(64) DEFAULT NULL COMMENT 'Payment Processor Name.',
  `description` varchar(255) DEFAULT NULL COMMENT 'Payment Processor Description.',
  `payment_processor_type_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this processor active?',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Is this processor the default?',
  `is_test` tinyint(4) DEFAULT NULL COMMENT 'Is this processor for a test site?',
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `signature` longtext DEFAULT NULL,
  `url_site` varchar(255) DEFAULT NULL,
  `url_api` varchar(255) DEFAULT NULL,
  `url_recur` varchar(255) DEFAULT NULL,
  `url_button` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `billing_mode` int(10) unsigned NOT NULL COMMENT 'Billing Mode',
  `is_recur` tinyint(4) DEFAULT NULL COMMENT 'Can process recurring contributions',
  `payment_type` int(10) unsigned DEFAULT 1 COMMENT 'Payment Type: Credit or Debit',
  `payment_instrument_id` int(10) unsigned DEFAULT 1 COMMENT 'Payment Instrument ID',
  `accepted_credit_cards` text DEFAULT NULL COMMENT 'array of accepted credit card types',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_test_domain_id` (`name`,`is_test`,`domain_id`),
  KEY `FK_civicrm_payment_processor_domain_id` (`domain_id`),
  KEY `FK_civicrm_payment_processor_payment_processor_type_id` (`payment_processor_type_id`)
);

DROP TABLE IF EXISTS `civicrm_payment_processor_type`;

CREATE TABLE `civicrm_payment_processor_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Processor Type ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Payment Processor Name.',
  `title` varchar(127) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL COMMENT 'Payment Processor Description.',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this processor active?',
  `is_default` tinyint(4) DEFAULT NULL COMMENT 'Is this processor the default?',
  `user_name_label` varchar(255) DEFAULT NULL,
  `password_label` varchar(255) DEFAULT NULL,
  `signature_label` varchar(255) DEFAULT NULL,
  `subject_label` varchar(255) DEFAULT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `url_site_default` varchar(255) DEFAULT NULL,
  `url_api_default` varchar(255) DEFAULT NULL,
  `url_recur_default` varchar(255) DEFAULT NULL,
  `url_button_default` varchar(255) DEFAULT NULL,
  `url_site_test_default` varchar(255) DEFAULT NULL,
  `url_api_test_default` varchar(255) DEFAULT NULL,
  `url_recur_test_default` varchar(255) DEFAULT NULL,
  `url_button_test_default` varchar(255) DEFAULT NULL,
  `billing_mode` int(10) unsigned NOT NULL COMMENT 'Billing Mode',
  `is_recur` tinyint(4) DEFAULT NULL COMMENT 'Can process recurring contributions',
  `payment_type` int(10) unsigned DEFAULT 1 COMMENT 'Payment Type: Credit or Debit',
  `payment_instrument_id` int(10) unsigned DEFAULT 1 COMMENT 'Payment Instrument ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`)
);

DROP TABLE IF EXISTS `civicrm_payment_token`;

CREATE TABLE `civicrm_payment_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Token ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID for the owner of the token',
  `payment_processor_id` int(10) unsigned NOT NULL,
  `token` varchar(255) NOT NULL COMMENT 'Externally provided token string',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date created',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'Contact ID of token creator',
  `expiry_date` datetime DEFAULT NULL COMMENT 'Date this token expires',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email at the time of token creation. Useful for fraud forensics',
  `billing_first_name` varchar(255) DEFAULT NULL COMMENT 'Billing first name at the time of token creation. Useful for fraud forensics',
  `billing_middle_name` varchar(255) DEFAULT NULL COMMENT 'Billing middle name at the time of token creation. Useful for fraud forensics',
  `billing_last_name` varchar(255) DEFAULT NULL COMMENT 'Billing last name at the time of token creation. Useful for fraud forensics',
  `masked_account_number` varchar(255) DEFAULT NULL COMMENT 'Holds the part of the card number or account details that may be retained or displayed',
  `ip_address` varchar(255) DEFAULT NULL COMMENT 'IP used when creating the token. Useful for fraud forensics',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_payment_token_contact_id` (`contact_id`),
  KEY `FK_civicrm_payment_token_payment_processor_id` (`payment_processor_id`),
  KEY `FK_civicrm_payment_token_created_id` (`created_id`)
);

DROP TABLE IF EXISTS `civicrm_pcp`;

CREATE TABLE `civicrm_pcp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Personal Campaign Page ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'FK to Contact ID',
  `status_id` int(10) unsigned NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `intro_text` text DEFAULT NULL,
  `page_text` text DEFAULT NULL,
  `donate_link_text` varchar(255) DEFAULT NULL,
  `page_id` int(10) unsigned NOT NULL COMMENT 'The Contribution or Event Page which triggered this pcp',
  `page_type` varchar(64) DEFAULT 'contribute' COMMENT 'The type of PCP this is: contribute or event',
  `pcp_block_id` int(10) unsigned NOT NULL COMMENT 'The pcp block that this pcp page was created from',
  `is_thermometer` int(10) unsigned DEFAULT 0,
  `is_honor_roll` int(10) unsigned DEFAULT 0,
  `goal_amount` decimal(20,2) DEFAULT NULL COMMENT 'Goal amount of this Personal Campaign Page.',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `is_active` tinyint(4) DEFAULT 0 COMMENT 'Is Personal Campaign Page enabled/active?',
  `is_notify` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_pcp_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_pcp_block`;

CREATE TABLE `civicrm_pcp_block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PCP block Id',
  `entity_table` varchar(64) DEFAULT NULL,
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_contribution_page.id OR civicrm_event.id',
  `target_entity_type` varchar(255) NOT NULL DEFAULT 'contribute' COMMENT 'The type of entity that this pcp targets',
  `target_entity_id` int(10) unsigned NOT NULL COMMENT 'The entity that this pcp targets',
  `supporter_profile_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_uf_group.id. Does Personal Campaign Page require manual activation by administrator? (is inactive by default after setup)?',
  `is_approval_needed` tinyint(4) DEFAULT NULL COMMENT 'Does Personal Campaign Page require manual activation by administrator? (is inactive by default after setup)?',
  `is_tellfriend_enabled` tinyint(4) DEFAULT NULL COMMENT 'Does Personal Campaign Page allow using tell a friend?',
  `tellfriend_limit` int(10) unsigned DEFAULT NULL COMMENT 'Maximum recipient fields allowed in tell a friend',
  `link_text` varchar(255) DEFAULT NULL COMMENT 'Link text for PCP.',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is Personal Campaign Page Block enabled/active?',
  `notify_email` varchar(255) DEFAULT NULL COMMENT 'If set, notification is automatically emailed to this email-address on create/update Personal Campaign Page',
  `owner_notify_id` int(11) DEFAULT NULL COMMENT 'FK to option_value where option_group = pcp_owner_notification',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_pcp_block_supporter_profile_id` (`supporter_profile_id`)
);

DROP TABLE IF EXISTS `civicrm_persistent`;

CREATE TABLE `civicrm_persistent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Persistent Record Id',
  `context` varchar(255) NOT NULL COMMENT 'Context for which name data pair is to be stored',
  `name` varchar(255) NOT NULL COMMENT 'Name of Context',
  `data` longtext DEFAULT NULL COMMENT 'data associated with name',
  `is_config` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Config Settings',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_phone`;

CREATE TABLE `civicrm_phone` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Phone ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Location does this phone belong to.',
  `is_primary` tinyint(4) DEFAULT 0 COMMENT 'Is this the primary phone for this contact and location.',
  `is_billing` tinyint(4) DEFAULT 0 COMMENT 'Is this the billing?',
  `mobile_provider_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Mobile Provider does this phone belong to.',
  `phone` varchar(32) DEFAULT NULL COMMENT 'Complete phone number.',
  `phone_ext` varchar(16) DEFAULT NULL COMMENT 'Optional extension for a phone number.',
  `phone_numeric` varchar(32) DEFAULT NULL COMMENT 'Phone number stripped of all whitespace, letters, and punctuation.',
  `phone_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which type of phone does this number belongs.',
  PRIMARY KEY (`id`),
  KEY `index_location_type` (`location_type_id`),
  KEY `index_is_primary` (`is_primary`),
  KEY `index_is_billing` (`is_billing`),
  KEY `UI_mobile_provider_id` (`mobile_provider_id`),
  KEY `FK_civicrm_phone_contact_id` (`contact_id`),
  KEY `phone_numeric_index` (`phone_numeric`)
);

DROP TABLE IF EXISTS `civicrm_pledge`;

CREATE TABLE `civicrm_pledge` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Pledge ID',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to civicrm_contact.id .',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Financial Type',
  `contribution_page_id` int(10) unsigned DEFAULT NULL COMMENT 'The Contribution Page which triggered this contribution',
  `amount` decimal(20,2) NOT NULL COMMENT 'Total pledged amount.',
  `original_installment_amount` decimal(20,2) NOT NULL COMMENT 'Original amount for each of the installments.',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `frequency_unit` varchar(8) DEFAULT 'month' COMMENT 'Time units for recurrence of pledge payments.',
  `frequency_interval` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'Number of time units for recurrence of pledge payments.',
  `frequency_day` int(10) unsigned NOT NULL DEFAULT 3 COMMENT 'Day in the period when the pledge payment is due e.g. 1st of month, 15th etc. Use this to set the scheduled dates for pledge payments.',
  `installments` int(10) unsigned DEFAULT 1 COMMENT 'Total number of payments to be made.',
  `start_date` datetime NOT NULL COMMENT 'The date the first scheduled pledge occurs.',
  `create_date` datetime NOT NULL COMMENT 'When this pledge record was created.',
  `acknowledge_date` datetime DEFAULT NULL COMMENT 'When a pledge acknowledgement message was sent to the contributor.',
  `modified_date` datetime DEFAULT NULL COMMENT 'Last updated date for this pledge record.',
  `cancel_date` datetime DEFAULT NULL COMMENT 'Date this pledge was cancelled by contributor.',
  `end_date` datetime DEFAULT NULL COMMENT 'Date this pledge finished successfully (total pledge payments equal to or greater than pledged amount).',
  `max_reminders` int(10) unsigned DEFAULT 1 COMMENT 'The maximum number of payment reminders to send for any given payment.',
  `initial_reminder_day` int(10) unsigned DEFAULT 5 COMMENT 'Send initial reminder this many days prior to the payment due date.',
  `additional_reminder_day` int(10) unsigned DEFAULT 5 COMMENT 'Send additional reminder this many days after last one sent, up to maximum number of reminders.',
  `status_id` int(10) unsigned DEFAULT NULL COMMENT 'Implicit foreign key to civicrm_option_values in the contribution_status option group.',
  `is_test` tinyint(4) DEFAULT 0,
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'The campaign for which this pledge has been initiated.',
  PRIMARY KEY (`id`),
  KEY `index_status` (`status_id`),
  KEY `FK_civicrm_pledge_contact_id` (`contact_id`),
  KEY `FK_civicrm_pledge_contribution_page_id` (`contribution_page_id`),
  KEY `FK_civicrm_pledge_campaign_id` (`campaign_id`),
  KEY `FK_civicrm_pledge_financial_type_id` (`financial_type_id`)
);

DROP TABLE IF EXISTS `civicrm_pledge_block`;

CREATE TABLE `civicrm_pledge_block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Pledge ID',
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'physical tablename for entity being joined to pledge, e.g. civicrm_contact',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `pledge_frequency_unit` varchar(128) DEFAULT NULL COMMENT 'Delimited list of supported frequency units',
  `is_pledge_interval` tinyint(4) DEFAULT 0 COMMENT 'Is frequency interval exposed on the contribution form.',
  `max_reminders` int(10) unsigned DEFAULT 1 COMMENT 'The maximum number of payment reminders to send for any given payment.',
  `initial_reminder_day` int(10) unsigned DEFAULT 5 COMMENT 'Send initial reminder this many days prior to the payment due date.',
  `additional_reminder_day` int(10) unsigned DEFAULT 5 COMMENT 'Send additional reminder this many days after last one sent, up to maximum number of reminders.',
  `pledge_start_date` varchar(64) DEFAULT NULL COMMENT 'The date that the first scheduled pledge occurs.',
  `is_pledge_start_date_visible` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'If true - recurring start date is shown.',
  `is_pledge_start_date_editable` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'If true - recurring start date is editable.',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`)
);

DROP TABLE IF EXISTS `civicrm_pledge_payment`;

CREATE TABLE `civicrm_pledge_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pledge_id` int(10) unsigned NOT NULL COMMENT 'FK to Pledge table',
  `contribution_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contribution table.',
  `scheduled_amount` decimal(20,2) NOT NULL COMMENT 'Pledged amount for this payment (the actual contribution amount might be different).',
  `actual_amount` decimal(20,2) DEFAULT NULL COMMENT 'Actual amount that is paid as the Pledged installment amount.',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `scheduled_date` datetime NOT NULL COMMENT 'The date the pledge payment is supposed to happen.',
  `reminder_date` datetime DEFAULT NULL COMMENT 'The date that the most recent payment reminder was sent.',
  `reminder_count` int(10) unsigned DEFAULT 0 COMMENT 'The number of payment reminders sent.',
  `status_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_contribution_pledge` (`contribution_id`,`pledge_id`),
  KEY `index_status` (`status_id`),
  KEY `FK_civicrm_pledge_payment_pledge_id` (`pledge_id`)
);

DROP TABLE IF EXISTS `civicrm_preferences_date`;

CREATE TABLE `civicrm_preferences_date` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT 'The meta name for this date (fixed in code)',
  `description` varchar(255) DEFAULT NULL COMMENT 'Description of this date type.',
  `start` int(11) NOT NULL COMMENT 'The start offset relative to current year',
  `end` int(11) NOT NULL COMMENT 'The end offset relative to current year, can be negative',
  `date_format` varchar(64) DEFAULT NULL COMMENT 'The date type',
  `time_format` varchar(64) DEFAULT NULL COMMENT 'time format',
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
);

DROP TABLE IF EXISTS `civicrm_premiums`;

CREATE TABLE `civicrm_premiums` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_table` varchar(64) NOT NULL COMMENT 'Joins these premium settings to another object. Always civicrm_contribution_page for now.',
  `entity_id` int(10) unsigned NOT NULL,
  `premiums_active` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Is the Premiums feature enabled for this page?',
  `premiums_intro_title` varchar(255) DEFAULT NULL COMMENT 'Title for Premiums section.',
  `premiums_intro_text` text DEFAULT NULL COMMENT 'Displayed in <div> at top of Premiums section of page. Text and HTML allowed.',
  `premiums_contact_email` varchar(100) DEFAULT NULL COMMENT 'This email address is included in receipts if it is populated and a premium has been selected.',
  `premiums_contact_phone` varchar(50) DEFAULT NULL COMMENT 'This phone number is included in receipts if it is populated and a premium has been selected.',
  `premiums_display_min_contribution` tinyint(4) NOT NULL COMMENT 'Boolean. Should we automatically display minimum contribution amount text after the premium descriptions.',
  `premiums_nothankyou_position` int(10) unsigned DEFAULT 1,
  `premiums_nothankyou_label` varchar(255) DEFAULT NULL COMMENT 'Label displayed for No Thank-you option in premiums block (e.g. No thank you)',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_premiums_product`;

CREATE TABLE `civicrm_premiums_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Contribution ID',
  `premiums_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to premiums settings record.',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to each product object.',
  `weight` int(10) unsigned NOT NULL,
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Financial Type.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_premiums_product_premiums_id` (`premiums_id`),
  KEY `FK_civicrm_premiums_product_product_id` (`product_id`),
  KEY `FK_civicrm_premiums_product_financial_type_id` (`financial_type_id`)
);

DROP TABLE IF EXISTS `civicrm_prevnext_cache`;

CREATE TABLE `civicrm_prevnext_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'physical tablename for entity being joined to discount, e.g. civicrm_event',
  `entity_id1` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `entity_id2` int(10) unsigned NOT NULL COMMENT 'FK to entity table specified in entity_table column.',
  `cacheKey` varchar(255) DEFAULT NULL COMMENT 'Unique path name for cache element of the searched item',
  `data` longtext DEFAULT NULL COMMENT 'cached snapshot of the serialized data',
  `is_selected` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `index_all` (`cacheKey`,`entity_id1`,`entity_id2`,`entity_table`,`is_selected`)
);

DROP TABLE IF EXISTS `civicrm_price_field`;

CREATE TABLE `civicrm_price_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price Field',
  `price_set_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_price_set',
  `name` varchar(255) NOT NULL COMMENT 'Variable name/programmatic handle for this field.',
  `label` varchar(255) NOT NULL COMMENT 'Text for form field label (also friendly name for administering this field).',
  `html_type` varchar(12) NOT NULL,
  `is_enter_qty` tinyint(4) DEFAULT 0 COMMENT 'Enter a quantity for this field?',
  `help_pre` text DEFAULT NULL COMMENT 'Description and/or help text to display before this field.',
  `help_post` text DEFAULT NULL COMMENT 'Description and/or help text to display after this field.',
  `weight` int(11) DEFAULT 1 COMMENT 'Order in which the fields should appear',
  `is_display_amounts` tinyint(4) DEFAULT 1 COMMENT 'Should the price be displayed next to the label for each option?',
  `options_per_line` int(10) unsigned DEFAULT 1 COMMENT 'number of options per line for checkbox and radio',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this price field active',
  `is_required` tinyint(4) DEFAULT 1 COMMENT 'Is this price field required (value must be > 1)',
  `active_on` datetime DEFAULT NULL COMMENT 'If non-zero, do not show this field before the date specified',
  `expire_on` datetime DEFAULT NULL COMMENT 'If non-zero, do not show this field after the date specified',
  `javascript` varchar(255) DEFAULT NULL COMMENT 'Optional scripting attributes for field',
  `visibility_id` int(10) unsigned DEFAULT 1 COMMENT 'Implicit FK to civicrm_option_group with name = ''visibility''',
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`),
  KEY `FK_civicrm_price_field_price_set_id` (`price_set_id`)
);

DROP TABLE IF EXISTS `civicrm_price_field_value`;

CREATE TABLE `civicrm_price_field_value` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price Field Value',
  `price_field_id` int(10) unsigned NOT NULL COMMENT 'FK to civicrm_price_field',
  `name` varchar(255) DEFAULT NULL COMMENT 'Price field option name',
  `label` varchar(255) DEFAULT NULL COMMENT 'Price field option label',
  `description` text DEFAULT NULL COMMENT '>Price field option description.',
  `amount` varchar(512) NOT NULL COMMENT 'Price field option amount',
  `count` int(10) unsigned DEFAULT NULL COMMENT 'Number of participants per field option',
  `max_value` int(10) unsigned DEFAULT NULL COMMENT 'Max number of participants per field options',
  `weight` int(11) DEFAULT 1 COMMENT 'Order in which the field options should appear',
  `membership_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Membership Type',
  `membership_num_terms` int(10) DEFAULT NULL COMMENT 'Maximum number of related memberships.',
  `is_default` tinyint(4) DEFAULT 0 COMMENT 'Is this default price field option',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this price field value active',
  `non_deductible_amount` decimal(20,2) NOT NULL DEFAULT 0.00 COMMENT 'Portion of total amount which is NOT tax deductible.',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Financial Type.',
  `help_pre` text DEFAULT NULL COMMENT 'Price field option pre help text.',
  `help_post` text DEFAULT NULL COMMENT 'Price field option post help text.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_price_field_value_price_field_id` (`price_field_id`),
  KEY `FK_civicrm_price_field_value_membership_type_id` (`membership_type_id`),
  KEY `FK_civicrm_price_field_value_financial_type_id` (`financial_type_id`)
);

DROP TABLE IF EXISTS `civicrm_price_set`;

CREATE TABLE `civicrm_price_set` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price Set',
  `domain_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Domain is this price-set for',
  `name` varchar(255) NOT NULL COMMENT 'Variable name/programmatic handle for this set of price fields.',
  `title` varchar(255) NOT NULL COMMENT 'Displayed title for the Price Set.',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this price set active',
  `help_pre` text DEFAULT NULL COMMENT 'Description and/or help text to display before fields in form.',
  `help_post` text DEFAULT NULL COMMENT 'Description and/or help text to display after fields in form.',
  `javascript` varchar(64) DEFAULT NULL COMMENT 'Optional Javascript script function(s) included on the form with this price_set. Can be used for conditional',
  `extends` varchar(255) NOT NULL COMMENT 'What components are using this price set?',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'If membership is paid by a contribution - what financial type should be used. FK to civicrm_financial_type.id',
  `is_quick_config` tinyint(4) DEFAULT 0 COMMENT 'Is set if edited on Contribution or Event Page rather than through Manage Price Sets',
  `is_reserved` tinyint(4) DEFAULT 0 COMMENT 'Is this a predefined system price set  (i.e. it can not be deleted, edited)?',
  `min_amount` int(10) unsigned DEFAULT 0 COMMENT 'Minimum Amount required for this set.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`),
  KEY `FK_civicrm_price_set_domain_id` (`domain_id`),
  KEY `FK_civicrm_price_set_financial_type_id` (`financial_type_id`)
);

DROP TABLE IF EXISTS `civicrm_price_set_entity`;

CREATE TABLE `civicrm_price_set_entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price Set Entity',
  `entity_table` varchar(64) NOT NULL COMMENT 'Table which uses this price set',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Item in table',
  `price_set_id` int(10) unsigned NOT NULL COMMENT 'price set being used',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_price_set_entity_price_set_id` (`price_set_id`)
);

DROP TABLE IF EXISTS `civicrm_print_label`;

CREATE TABLE `civicrm_print_label` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT 'User title for for this label layout',
  `name` varchar(255) DEFAULT NULL COMMENT 'variable name/programmatic handle for this field.',
  `description` text DEFAULT NULL COMMENT 'Description of this label layout',
  `label_format_name` varchar(255) DEFAULT NULL COMMENT 'This refers to name column of civicrm_option_value row in name_badge option group',
  `label_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Implicit FK to civicrm_option_value row in NEW label_type option group',
  `data` longtext DEFAULT NULL COMMENT 'contains json encode configurations options',
  `is_default` tinyint(4) DEFAULT 1 COMMENT 'Is this default?',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this option active?',
  `is_reserved` tinyint(4) DEFAULT 1 COMMENT 'Is this reserved label?',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this label layout',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_print_label_created_id` (`created_id`)
);

DROP TABLE IF EXISTS `civicrm_product`;

CREATE TABLE `civicrm_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'Required product/premium name',
  `description` text DEFAULT NULL COMMENT 'Optional description of the product/premium.',
  `sku` varchar(50) DEFAULT NULL COMMENT 'Optional product sku or code.',
  `options` text DEFAULT NULL COMMENT 'Store comma-delimited list of color, size, etc. options for the product.',
  `image` varchar(255) DEFAULT NULL COMMENT 'Full or relative URL to uploaded image - fullsize.',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT 'Full or relative URL to image thumbnail.',
  `price` decimal(20,2) DEFAULT NULL COMMENT 'Sell price or market value for premiums. For tax-deductible contributions, this will be stored as non_deductible_amount in the contribution record.',
  `currency` varchar(3) DEFAULT NULL COMMENT '3 character string, value from config setting or input via user.',
  `min_contribution` decimal(20,2) DEFAULT NULL COMMENT 'Minimum contribution required to be eligible to select this premium.',
  `cost` decimal(20,2) DEFAULT NULL COMMENT 'Actual cost of this product. Useful to determine net return from sale or using this as an incentive.',
  `is_active` tinyint(4) NOT NULL COMMENT 'Disabling premium removes it from the premiums_premium join table below.',
  `period_type` varchar(8) DEFAULT 'rolling' COMMENT 'Rolling means we set start/end based on current day, fixed means we set start/end for current year or month(e.g. 1 year + fixed -> we would set start/end for 1/1/06 thru 12/31/06 for any premium chosen in 2006) ',
  `fixed_period_start_day` int(11) DEFAULT 101 COMMENT 'Month and day (MMDD) that fixed period type subscription or membership starts.',
  `duration_unit` varchar(8) DEFAULT 'year',
  `duration_interval` int(11) DEFAULT NULL COMMENT 'Number of units for total duration of subscription, service, membership (e.g. 12 Months).',
  `frequency_unit` varchar(8) DEFAULT 'month' COMMENT 'Frequency unit and interval allow option to store actual delivery frequency for a subscription or service.',
  `frequency_interval` int(11) DEFAULT NULL COMMENT 'Number of units for delivery frequency of subscription, service, membership (e.g. every 3 Months).',
  `financial_type_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Financial Type.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_product_financial_type_id` (`financial_type_id`)
);

DROP TABLE IF EXISTS `civicrm_queue_item`;

CREATE TABLE `civicrm_queue_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `queue_name` varchar(64) NOT NULL COMMENT 'Name of the queue which includes this item',
  `weight` int(11) NOT NULL,
  `submit_time` datetime NOT NULL COMMENT 'date on which this item was submitted to the queue',
  `release_time` datetime DEFAULT NULL COMMENT 'date on which this job becomes available null if ASAP',
  `data` text DEFAULT NULL COMMENT 'Serialized queue',
  PRIMARY KEY (`id`),
  KEY `index_queueids` (`queue_name`,`weight`,`id`)
);

DROP TABLE IF EXISTS `civicrm_recurring_entity`;

CREATE TABLE `civicrm_recurring_entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'recurring entity parent id',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'recurring entity child id',
  `entity_table` varchar(64) NOT NULL COMMENT 'physical tablename for entity, e.g. civicrm_event',
  `mode` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1-this entity, 2-this and the following entities, 3-all the entities',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_relationship`;

CREATE TABLE `civicrm_relationship` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Relationship ID',
  `contact_id_a` int(10) unsigned NOT NULL COMMENT 'id of the first contact',
  `contact_id_b` int(10) unsigned NOT NULL COMMENT 'id of the second contact',
  `relationship_type_id` int(10) unsigned NOT NULL COMMENT 'id of the relationship',
  `start_date` date DEFAULT NULL COMMENT 'date when the relationship started',
  `end_date` date DEFAULT NULL COMMENT 'date when the relationship ended',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'is the relationship active ?',
  `description` varchar(255) DEFAULT NULL COMMENT 'Optional verbose description for the relationship.',
  `is_permission_a_b` tinyint(4) DEFAULT 0 COMMENT 'is contact a has permission to view / edit contact and\n  related data for contact b ?',
  `is_permission_b_a` tinyint(4) DEFAULT 0 COMMENT 'is contact b has permission to view / edit contact and\n  related data for contact a ?',
  `case_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_case',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_relationship_contact_id_a` (`contact_id_a`),
  KEY `FK_civicrm_relationship_contact_id_b` (`contact_id_b`),
  KEY `FK_civicrm_relationship_relationship_type_id` (`relationship_type_id`),
  KEY `FK_civicrm_relationship_case_id` (`case_id`)
);

DROP TABLE IF EXISTS `civicrm_relationship_type`;

CREATE TABLE `civicrm_relationship_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `name_a_b` varchar(64) DEFAULT NULL COMMENT 'name for relationship of contact_a to contact_b.',
  `label_a_b` varchar(64) DEFAULT NULL COMMENT 'label for relationship of contact_a to contact_b.',
  `name_b_a` varchar(64) DEFAULT NULL COMMENT 'Optional name for relationship of contact_b to contact_a.',
  `label_b_a` varchar(64) DEFAULT NULL COMMENT 'Optional label for relationship of contact_b to contact_a.',
  `description` varchar(255) DEFAULT NULL COMMENT 'Optional verbose description of the relationship type.',
  `contact_type_a` varchar(12) DEFAULT NULL COMMENT 'If defined, contact_a in a relationship of this type must be a specific contact_type.',
  `contact_type_b` varchar(12) DEFAULT NULL COMMENT 'If defined, contact_b in a relationship of this type must be a specific contact_type.',
  `contact_sub_type_a` varchar(64) DEFAULT NULL COMMENT 'If defined, contact_sub_type_a in a relationship of this type must be a specific contact_sub_type.',
  `contact_sub_type_b` varchar(64) DEFAULT NULL COMMENT 'If defined, contact_sub_type_b in a relationship of this type must be a specific contact_sub_type.',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this relationship type a predefined system type (can not be changed or de-activated)?',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this relationship type currently active (i.e. can be used when creating or editing relationships)?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_a_b` (`name_a_b`),
  UNIQUE KEY `UI_name_b_a` (`name_b_a`)
);

DROP TABLE IF EXISTS `civicrm_report_instance`;

CREATE TABLE `civicrm_report_instance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Instance ID',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this instance for',
  `title` varchar(255) DEFAULT NULL COMMENT 'Report Instance Title.',
  `report_id` varchar(64) NOT NULL COMMENT 'FK to civicrm_option_value for the report template',
  `name` varchar(255) DEFAULT NULL COMMENT 'when combined with report_id/template uniquely identifies the instance',
  `args` varchar(255) DEFAULT NULL COMMENT 'arguments that are passed in the url when invoking the instance',
  `description` varchar(255) DEFAULT NULL COMMENT 'Report Instance description.',
  `permission` varchar(255) DEFAULT NULL COMMENT 'permission required to be able to run this instance',
  `grouprole` varchar(1024) DEFAULT NULL COMMENT 'role required to be able to run this instance',
  `form_values` text DEFAULT NULL COMMENT 'Submitted form values for this report',
  `is_active` tinyint(4) DEFAULT NULL COMMENT 'Is this entry active?',
  `email_subject` varchar(255) DEFAULT NULL COMMENT 'Subject of email',
  `email_to` text DEFAULT NULL COMMENT 'comma-separated list of email addresses to send the report to',
  `email_cc` text DEFAULT NULL COMMENT 'comma-separated list of email addresses to send the report to',
  `header` text DEFAULT NULL COMMENT 'comma-separated list of email addresses to send the report to',
  `footer` text DEFAULT NULL COMMENT 'comma-separated list of email addresses to send the report to',
  `navigation_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to navigation ID',
  `is_reserved` tinyint(4) DEFAULT 0,
  `drilldown_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to instance ID drilldown to',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contact table.',
  `owner_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to contact table.',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_report_instance_domain_id` (`domain_id`),
  KEY `FK_civicrm_report_instance_navigation_id` (`navigation_id`),
  KEY `FK_civicrm_report_instance_drilldown_id` (`drilldown_id`),
  KEY `FK_civicrm_report_instance_created_id` (`created_id`),
  KEY `FK_civicrm_report_instance_owner_id` (`owner_id`)
);

DROP TABLE IF EXISTS `civicrm_saved_search`;

CREATE TABLE `civicrm_saved_search` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Saved search ID',
  `form_values` text DEFAULT NULL COMMENT 'Submitted form values for this search',
  `mapping_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to civicrm_mapping used for saved search-builder searches.',
  `search_custom_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to civicrm_option value table used for saved custom searches.',
  `where_clause` text DEFAULT NULL COMMENT 'the sql where clause if a saved search acl',
  `select_tables` text DEFAULT NULL COMMENT 'the tables to be included in a select data',
  `where_tables` text DEFAULT NULL COMMENT 'the tables to be included in the count statement',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_saved_search_mapping_id` (`mapping_id`)
);

DROP TABLE IF EXISTS `civicrm_setting`;

CREATE TABLE `civicrm_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Unique name for setting',
  `value` text DEFAULT NULL COMMENT 'data associated with this group / name combo',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this menu item for',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID if the setting is localized to a contact',
  `is_domain` tinyint(4) DEFAULT NULL COMMENT 'Is this setting a contact specific or site wide setting?',
  `component_id` int(10) unsigned DEFAULT NULL COMMENT 'Component that this menu item belongs to',
  `created_date` datetime DEFAULT NULL COMMENT 'When was the setting created',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this setting',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_domain_contact_name` (`domain_id`,`contact_id`,`name`),
  KEY `FK_civicrm_setting_domain_id` (`domain_id`),
  KEY `FK_civicrm_setting_contact_id` (`contact_id`),
  KEY `FK_civicrm_setting_component_id` (`component_id`),
  KEY `FK_civicrm_setting_created_id` (`created_id`)
);

DROP TABLE IF EXISTS `civicrm_sms_provider`;

CREATE TABLE `civicrm_sms_provider` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'SMS Provider ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Provider internal name points to option_value of option_group sms_provider_name',
  `title` varchar(64) DEFAULT NULL COMMENT 'Provider name visible to user',
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `api_type` int(10) unsigned NOT NULL COMMENT 'points to value in civicrm_option_value for group sms_api_type',
  `api_url` varchar(128) DEFAULT NULL,
  `api_params` text DEFAULT NULL COMMENT 'the api params in xml, http or smtp format',
  `is_default` tinyint(4) DEFAULT 0,
  `is_active` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_state_province`;

CREATE TABLE `civicrm_state_province` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'State / Province ID',
  `name` varchar(64) DEFAULT NULL COMMENT 'Name of State / Province',
  `abbreviation` varchar(4) DEFAULT NULL COMMENT '2-4 Character Abbreviation of State / Province',
  `country_id` int(10) unsigned NOT NULL COMMENT 'ID of Country that State / Province belong',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name_country_id` (`name`,`country_id`),
  KEY `FK_civicrm_state_province_country_id` (`country_id`)
);

DROP TABLE IF EXISTS `civicrm_status_pref`;

CREATE TABLE `civicrm_status_pref` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Status Preference ID',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this Status Preference for',
  `name` varchar(255) NOT NULL COMMENT 'Name of the status check this preference references.',
  `hush_until` date DEFAULT NULL COMMENT 'expires ignore_severity.  NULL never hushes.',
  `ignore_severity` int(10) unsigned DEFAULT 1 COMMENT 'Hush messages up to and including this severity.',
  `prefs` varchar(255) DEFAULT NULL COMMENT 'These settings are per-check, and can''t be compared across checks.',
  `check_info` varchar(255) DEFAULT NULL COMMENT 'These values are per-check, and can''t be compared across checks.',
  PRIMARY KEY (`id`),
  KEY `UI_status_pref_name` (`name`),
  KEY `FK_civicrm_status_pref_domain_id` (`domain_id`)
);

DROP TABLE IF EXISTS `civicrm_subscription_history`;

CREATE TABLE `civicrm_subscription_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Internal Id',
  `contact_id` int(10) unsigned NOT NULL COMMENT 'Contact Id',
  `group_id` int(10) unsigned DEFAULT NULL COMMENT 'Group Id',
  `date` datetime NOT NULL COMMENT 'Date of the (un)subscription',
  `method` varchar(8) DEFAULT NULL COMMENT 'How the (un)subscription was triggered',
  `status` varchar(8) DEFAULT NULL COMMENT 'The state of the contact within the group',
  `tracking` varchar(255) DEFAULT NULL COMMENT 'IP address or other tracking info',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_subscription_history_contact_id` (`contact_id`),
  KEY `FK_civicrm_subscription_history_group_id` (`group_id`)
);

DROP TABLE IF EXISTS `civicrm_survey`;

CREATE TABLE `civicrm_survey` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Survey id.',
  `title` varchar(255) NOT NULL COMMENT 'Title of the Survey.',
  `campaign_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to the Campaign.',
  `activity_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Implicit FK to civicrm_option_value where option_group = activity_type',
  `recontact_interval` text DEFAULT NULL COMMENT 'Recontact intervals for each status.',
  `instructions` text DEFAULT NULL COMMENT 'Script instructions for volunteers to use for the survey.',
  `release_frequency` int(10) unsigned DEFAULT NULL COMMENT 'Number of days for recurrence of release.',
  `max_number_of_contacts` int(10) unsigned DEFAULT NULL COMMENT 'Maximum number of contacts to allow for survey.',
  `default_number_of_contacts` int(10) unsigned DEFAULT NULL COMMENT 'Default number of contacts to allow for survey.',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this survey enabled or disabled/cancelled?',
  `is_default` tinyint(4) DEFAULT 0 COMMENT 'Is this default survey?',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this Survey.',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time that Survey was created.',
  `last_modified_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who recently edited this Survey.',
  `last_modified_date` datetime DEFAULT NULL COMMENT 'Date and time that Survey was edited last time.',
  `result_id` int(10) unsigned DEFAULT NULL COMMENT 'Used to store option group id.',
  `bypass_confirm` tinyint(4) DEFAULT 0 COMMENT 'Bypass the email verification.',
  `thankyou_title` varchar(255) DEFAULT NULL COMMENT 'Title for Thank-you page (header title tag, and display at the top of the page).',
  `thankyou_text` text DEFAULT NULL COMMENT 'text and html allowed. displayed above result on success page',
  `is_share` tinyint(4) DEFAULT 1 COMMENT 'Can people share the petition through social media?',
  PRIMARY KEY (`id`),
  KEY `UI_activity_type_id` (`activity_type_id`),
  KEY `FK_civicrm_survey_campaign_id` (`campaign_id`),
  KEY `FK_civicrm_survey_created_id` (`created_id`),
  KEY `FK_civicrm_survey_last_modified_id` (`last_modified_id`)
);

DROP TABLE IF EXISTS `civicrm_system_log`;

CREATE TABLE `civicrm_system_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: ID.',
  `message` varchar(128) NOT NULL COMMENT 'Standardized message',
  `context` longtext DEFAULT NULL COMMENT 'JSON encoded data',
  `level` varchar(9) NOT NULL DEFAULT 'info' COMMENT 'error level per PSR3',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Timestamp of when event occurred.',
  `contact_id` int(11) DEFAULT NULL COMMENT 'Optional Contact ID that created the log. Not an FK as we keep this regardless',
  `hostname` varchar(128) NOT NULL COMMENT 'Optional Name of logging host',
  PRIMARY KEY (`id`),
  KEY `message` (`message`),
  KEY `contact_id` (`contact_id`),
  KEY `level` (`level`)
);

DROP TABLE IF EXISTS `civicrm_tag`;

CREATE TABLE `civicrm_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag ID',
  `name` varchar(64) NOT NULL COMMENT 'Name of Tag.',
  `description` varchar(255) DEFAULT NULL COMMENT 'Optional verbose description of the tag.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional parent id for this tag.',
  `is_selectable` tinyint(4) DEFAULT 1 COMMENT 'Is this tag selectable / displayed',
  `is_reserved` tinyint(4) DEFAULT 0,
  `is_tagset` tinyint(4) DEFAULT 0,
  `used_for` varchar(64) DEFAULT NULL,
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this tag',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time that tag was created.',
  `color` varchar(255) DEFAULT NULL COMMENT 'Hex color value e.g. #ffffff',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_name` (`name`),
  KEY `FK_civicrm_tag_parent_id` (`parent_id`),
  KEY `FK_civicrm_tag_created_id` (`created_id`)
);

DROP TABLE IF EXISTS `civicrm_tell_friend`;

CREATE TABLE `civicrm_tell_friend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Friend ID',
  `entity_table` varchar(64) NOT NULL COMMENT 'Name of table where item being referenced is stored.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to the referenced item.',
  `title` varchar(255) DEFAULT NULL,
  `intro` text DEFAULT NULL COMMENT 'Introductory message to contributor or participant displayed on the Tell a Friend form.',
  `suggested_message` text DEFAULT NULL COMMENT 'Suggested message to friends, provided as default on the Tell A Friend form.',
  `general_link` varchar(255) DEFAULT NULL COMMENT 'URL for general info about the organization - included in the email sent to friends.',
  `thankyou_title` varchar(255) DEFAULT NULL COMMENT 'Text for Tell a Friend thank you page header and HTML title.',
  `thankyou_text` text DEFAULT NULL COMMENT 'Thank you message displayed on success page.',
  `is_active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `civicrm_timezone`;

CREATE TABLE `civicrm_timezone` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Timezone Id',
  `name` varchar(64) DEFAULT NULL COMMENT 'Timezone full name',
  `abbreviation` char(3) DEFAULT NULL COMMENT 'ISO Code for timezone abbreviation',
  `gmt` varchar(64) DEFAULT NULL COMMENT 'GMT name of the timezone',
  `offset` int(11) DEFAULT NULL,
  `country_id` int(10) unsigned NOT NULL COMMENT 'Country Id',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_timezone_country_id` (`country_id`)
);

DROP TABLE IF EXISTS `civicrm_uf_field`;

CREATE TABLE `civicrm_uf_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `uf_group_id` int(10) unsigned NOT NULL COMMENT 'Which form does this field belong to.',
  `field_name` varchar(64) NOT NULL COMMENT 'Name for CiviCRM field which is being exposed for sharing.',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this field currently shareable? If false, hide the field for all sharing contexts.',
  `is_view` tinyint(4) DEFAULT 0 COMMENT 'the field is view only and not editable in user forms.',
  `is_required` tinyint(4) DEFAULT 0 COMMENT 'Is this field required when included in a user or registration form?',
  `weight` int(11) NOT NULL DEFAULT 1 COMMENT 'Controls field display order when user framework fields are displayed in registration and account editing forms.',
  `help_post` text DEFAULT NULL COMMENT 'Description and/or help text to display after this field.',
  `help_pre` text DEFAULT NULL COMMENT 'Description and/or help text to display before this field.',
  `visibility` varchar(32) DEFAULT 'User and User Admin Only' COMMENT 'In what context(s) is this field visible.',
  `in_selector` tinyint(4) DEFAULT 0 COMMENT 'Is this field included as a column in the selector table?',
  `is_searchable` tinyint(4) DEFAULT 0 COMMENT 'Is this field included search form of profile?',
  `location_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Location type of this mapping, if required',
  `phone_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Phone Type Id, if required',
  `website_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Website Type Id, if required',
  `label` varchar(255) NOT NULL COMMENT 'To save label for fields.',
  `field_type` varchar(255) DEFAULT NULL COMMENT 'This field saves field type (ie individual,household.. field etc).',
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this field reserved for use by some other CiviCRM functionality?',
  `is_multi_summary` tinyint(4) DEFAULT 0 COMMENT 'Include in multi-record listing?',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_uf_field_uf_group_id` (`uf_group_id`),
  KEY `FK_civicrm_uf_field_location_type_id` (`location_type_id`),
  KEY `IX_website_type_id` (`website_type_id`)
);

DROP TABLE IF EXISTS `civicrm_uf_group`;

CREATE TABLE `civicrm_uf_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this form currently active? If false, hide all related fields for all sharing contexts.',
  `group_type` varchar(255) DEFAULT NULL COMMENT 'This column will store a comma separated list of the type(s) of profile fields.',
  `title` varchar(64) NOT NULL COMMENT 'Form title.',
  `description` text DEFAULT NULL COMMENT 'Optional verbose description of the profile.',
  `help_pre` text DEFAULT NULL COMMENT 'Description and/or help text to display before fields in form.',
  `help_post` text DEFAULT NULL COMMENT 'Description and/or help text to display after fields in form.',
  `limit_listings_group_id` int(10) unsigned DEFAULT NULL COMMENT 'Group id, foriegn key from civicrm_group',
  `post_URL` varchar(255) DEFAULT NULL COMMENT 'Redirect to URL.',
  `add_to_group_id` int(10) unsigned DEFAULT NULL COMMENT 'foreign key to civicrm_group_id',
  `add_captcha` tinyint(4) DEFAULT 0 COMMENT 'Should a CAPTCHA widget be included this Profile form.',
  `is_map` tinyint(4) DEFAULT 0 COMMENT 'Do we want to map results from this profile.',
  `is_edit_link` tinyint(4) DEFAULT 0 COMMENT 'Should edit link display in profile selector',
  `is_uf_link` tinyint(4) DEFAULT 0 COMMENT 'Should we display a link to the website profile in profile selector',
  `is_update_dupe` tinyint(4) DEFAULT 0 COMMENT 'Should we update the contact record if we find a duplicate',
  `cancel_URL` varchar(255) DEFAULT NULL COMMENT 'Redirect to URL when Cancle button clik .',
  `is_cms_user` tinyint(4) DEFAULT 0 COMMENT 'Should we create a cms user for this profile ',
  `notify` text DEFAULT NULL,
  `is_reserved` tinyint(4) DEFAULT NULL COMMENT 'Is this group reserved for use by some other CiviCRM functionality?',
  `name` varchar(64) DEFAULT NULL COMMENT 'Name of the UF group for directly addressing it in the codebase',
  `created_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_contact, who created this UF group',
  `created_date` datetime DEFAULT NULL COMMENT 'Date and time this UF group was created.',
  `is_proximity_search` tinyint(4) DEFAULT 0 COMMENT 'Should we include proximity search feature in this profile search form?',
  PRIMARY KEY (`id`),
  KEY `FK_civicrm_uf_group_limit_listings_group_id` (`limit_listings_group_id`),
  KEY `FK_civicrm_uf_group_add_to_group_id` (`add_to_group_id`),
  KEY `FK_civicrm_uf_group_created_id` (`created_id`)
);

DROP TABLE IF EXISTS `civicrm_uf_join`;

CREATE TABLE `civicrm_uf_join` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique table ID',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this join currently active?',
  `module` varchar(64) NOT NULL COMMENT 'Module which owns this uf_join instance, e.g. User Registration, CiviDonate, etc.',
  `entity_table` varchar(64) DEFAULT NULL COMMENT 'Name of table where item being referenced is stored. Modules which only need a single collection of uf_join instances may choose not to populate entity_table and entity_id.',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to the referenced item.',
  `weight` int(11) NOT NULL DEFAULT 1 COMMENT 'Controls display order when multiple user framework groups are setup for concurrent display.',
  `uf_group_id` int(10) unsigned NOT NULL COMMENT 'Which form does this field belong to.',
  `module_data` longtext DEFAULT NULL COMMENT 'Json serialized array of data used by the ufjoin.module',
  PRIMARY KEY (`id`),
  KEY `index_entity` (`entity_table`,`entity_id`),
  KEY `FK_civicrm_uf_join_uf_group_id` (`uf_group_id`)
);

DROP TABLE IF EXISTS `civicrm_uf_match`;

CREATE TABLE `civicrm_uf_match` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'System generated ID.',
  `domain_id` int(10) unsigned NOT NULL COMMENT 'Which Domain is this match entry for',
  `uf_id` int(10) unsigned NOT NULL COMMENT 'UF ID',
  `uf_name` varchar(128) DEFAULT NULL COMMENT 'UF Name',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `language` varchar(5) DEFAULT NULL COMMENT 'UI language preferred by the given user/contact',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_uf_name_domain_id` (`uf_name`,`domain_id`),
  UNIQUE KEY `UI_contact_domain_id` (`contact_id`,`domain_id`),
  KEY `I_civicrm_uf_match_uf_id` (`uf_id`),
  KEY `FK_civicrm_uf_match_domain_id` (`domain_id`)
);

DROP TABLE IF EXISTS `civicrm_value_amaze_23`;

CREATE TABLE `civicrm_value_amaze_23` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `amaze_id_104` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_amaze_id_104` (`amaze_id_104`)
);

DROP TABLE IF EXISTS `civicrm_value_archiving_custom_data_22`;

CREATE TABLE `civicrm_value_archiving_custom_data_22` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `archiving_box_barcode_103` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_archiving_box_barcode_103` (`archiving_box_barcode_103`)
);

DROP TABLE IF EXISTS `civicrm_value_bioresource_sub_study_28`;

CREATE TABLE `civicrm_value_bioresource_sub_study_28` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `sub_study_118` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_sub_study_118` (`sub_study_118`)
);

DROP TABLE IF EXISTS `civicrm_value_brave_16`;

CREATE TABLE `civicrm_value_brave_16` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `brave_id_74` varchar(255) DEFAULT NULL,
  `brave_source_study_75` varchar(255) DEFAULT NULL,
  `briccs_id_86` varchar(255) DEFAULT NULL,
  `brave_family_id_87` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_brave_id_74` (`brave_id_74`),
  KEY `INDEX_brave_source_study_75` (`brave_source_study_75`),
  KEY `INDEX_briccs_id_86` (`briccs_id_86`),
  KEY `INDEX_brave_family_id_87` (`brave_family_id_87`)
);

DROP TABLE IF EXISTS `civicrm_value_briccs_recruitment_data_10`;

CREATE TABLE `civicrm_value_briccs_recruitment_data_10` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `briccs_id_31` varchar(255) DEFAULT NULL,
  `interview_date_and_time_32` datetime DEFAULT NULL,
  `interviewer_33` varchar(255) DEFAULT NULL,
  `interview_status_34` varchar(255) DEFAULT NULL,
  `consent_understands_consent_35` tinyint(4) DEFAULT NULL,
  `consent_blood_and_urine_36` tinyint(4) DEFAULT NULL,
  `consent_briccs_database_37` tinyint(4) DEFAULT NULL,
  `consent_further_contact_38` tinyint(4) DEFAULT NULL,
  `consent_understands_withdrawal_39` tinyint(4) DEFAULT NULL,
  `recruitment_type_40` varchar(255) DEFAULT NULL,
  `invitation_for__116` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_briccs_id_31` (`briccs_id_31`),
  KEY `INDEX_consent_blood_and_urine_36` (`consent_blood_and_urine_36`),
  KEY `INDEX_consent_briccs_database_37` (`consent_briccs_database_37`),
  KEY `INDEX_consent_further_contact_38` (`consent_further_contact_38`),
  KEY `INDEX_consent_understands_consent_35` (`consent_understands_consent_35`),
  KEY `INDEX_consent_understands_withdrawal_39` (`consent_understands_withdrawal_39`),
  KEY `INDEX_interview_date_and_time_32` (`interview_date_and_time_32`),
  KEY `INDEX_interview_status_34` (`interview_status_34`),
  KEY `INDEX_interviewer_33` (`interviewer_33`),
  KEY `INDEX_recruitment_type_40` (`recruitment_type_40`),
  KEY `INDEX_invitation_for__116` (`invitation_for__116`)
);

DROP TABLE IF EXISTS `civicrm_value_cardiomet_31`;

CREATE TABLE `civicrm_value_cardiomet_31` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `cardiomet_id_123` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_cardiomet_id_123` (`cardiomet_id_123`)
);

DROP TABLE IF EXISTS `civicrm_value_ccg_data_14`;

CREATE TABLE `civicrm_value_ccg_data_14` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `ccg_code_52` varchar(255) DEFAULT NULL,
  `genvasc_principal_investigator_56` varchar(255) DEFAULT NULL,
  `clrn_site_id_57` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_ccg_code_52` (`ccg_code_52`),
  KEY `INDEX_genvasc_principal_investigator_56` (`genvasc_principal_investigator_56`),
  KEY `INDEX_clrn_site_id_57` (`clrn_site_id_57`)
);

DROP TABLE IF EXISTS `civicrm_value_contact_ids_1`;

CREATE TABLE `civicrm_value_contact_ids_1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `nhs_number_1` varchar(255) DEFAULT NULL,
  `uhl_s_number_2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `dedupe_index_nhs_number_1` (`nhs_number_1`),
  KEY `dedupe_index_uhl_s_number_2` (`uhl_s_number_2`)
);

DROP TABLE IF EXISTS `civicrm_value_discordance_36`;

CREATE TABLE `civicrm_value_discordance_36` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `discordance_id_130` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_discordance_id_130` (`discordance_id_130`)
);

DROP TABLE IF EXISTS `civicrm_value_dream_recruitment_data_6`;

CREATE TABLE `civicrm_value_dream_recruitment_data_6` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `dream_study_id_18` varchar(255) DEFAULT NULL,
  `consent_to_participate_in_dream__19` tinyint(4) DEFAULT NULL,
  `consent_to_store_dream_study_sam_20` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_dream_study_id_18` (`dream_study_id_18`),
  KEY `INDEX_consent_to_store_dream_study_sam_20` (`consent_to_store_dream_study_sam_20`)
);

DROP TABLE IF EXISTS `civicrm_value_emmace_4_recruitment_data_13`;

CREATE TABLE `civicrm_value_emmace_4_recruitment_data_13` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `emmace_4_id_50` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_emmace_4_id_50` (`emmace_4_id_50`)
 );

DROP TABLE IF EXISTS `civicrm_value_fast_24`;

CREATE TABLE `civicrm_value_fast_24` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `fast_id_106` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_fast_id_106` (`fast_id_106`)
);

DROP TABLE IF EXISTS `civicrm_value_foami_27`;

CREATE TABLE `civicrm_value_foami_27` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `foami_id_117` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_foami_id_117` (`foami_id_117`)
);

DROP TABLE IF EXISTS `civicrm_value_genvasc_invoice_data_25`;

CREATE TABLE `civicrm_value_genvasc_invoice_data_25` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `invoice_year_107` varchar(255) DEFAULT NULL,
  `invoice_quarter_108` varchar(255) DEFAULT NULL,
  `processed_by_110` varchar(255) DEFAULT NULL,
  `processed_date_111` datetime DEFAULT NULL,
  `reimbursed_status_114` varchar(255) DEFAULT NULL,
  `notes_115` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_invoice_year_107` (`invoice_year_107`),
  KEY `INDEX_invoice_quarter_108` (`invoice_quarter_108`),
  KEY `INDEX_processed_by_110` (`processed_by_110`),
  KEY `INDEX_processed_date_111` (`processed_date_111`),
  KEY `INDEX_reimbursed_status_114` (`reimbursed_status_114`)
);

DROP TABLE IF EXISTS `civicrm_value_genvasc_invoice_data_save`;

CREATE TABLE `civicrm_value_genvasc_invoice_data_save` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `invoice_year_107` varchar(255) DEFAULT NULL,
  `invoice_quarter_108` varchar(255) DEFAULT NULL,
  `reimbursed_109` varchar(255) DEFAULT NULL,
  `processed_by_110` varchar(255) DEFAULT NULL,
  `processed_date_111` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_invoice_year_107` (`invoice_year_107`),
  KEY `INDEX_invoice_quarter_108` (`invoice_quarter_108`),
  KEY `INDEX_reimbursed_109` (`reimbursed_109`),
  KEY `INDEX_processed_by_110` (`processed_by_110`),
  KEY `INDEX_processed_date_111` (`processed_date_111`)
);

DROP TABLE IF EXISTS `civicrm_value_genvasc_recruitment_data_5`;

CREATE TABLE `civicrm_value_genvasc_recruitment_data_5` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `genvasc_recruitment_site_ice_cod_9` varchar(255) DEFAULT NULL,
  `genvasc_id_10` varchar(255) DEFAULT NULL,
  `genvasc_consent_q1_11` tinyint(4) DEFAULT NULL,
  `genvasc_consent_q2_12` tinyint(4) DEFAULT NULL,
  `genvasc_consent_q3_13` tinyint(4) DEFAULT NULL,
  `genvasc_consent_q4_14` tinyint(4) DEFAULT NULL,
  `genvasc_consent_q5_15` tinyint(4) DEFAULT NULL,
  `genvasc_consent_q6_16` tinyint(4) DEFAULT NULL,
  `genvasc_consent_q7_17` tinyint(4) DEFAULT NULL,
  `genvasc_post_code_51` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_genvasc_consent_q7_17` (`genvasc_consent_q7_17`),
  KEY `INDEX_genvasc_consent_q1_11` (`genvasc_consent_q1_11`),
  KEY `INDEX_genvasc_consent_q2_12` (`genvasc_consent_q2_12`),
  KEY `INDEX_genvasc_consent_q3_13` (`genvasc_consent_q3_13`),
  KEY `INDEX_genvasc_consent_q4_14` (`genvasc_consent_q4_14`),
  KEY `INDEX_genvasc_consent_q5_15` (`genvasc_consent_q5_15`),
  KEY `INDEX_genvasc_consent_q6_16` (`genvasc_consent_q6_16`),
  KEY `INDEX_genvasc_post_code_51` (`genvasc_post_code_51`),
  KEY `idx_civicrm_value_genvasc_recruitment_data_5_genvasc_id_10` (`genvasc_id_10`)
);

DROP TABLE IF EXISTS `civicrm_value_genvasc_site_management_19`;

CREATE TABLE `civicrm_value_genvasc_site_management_19` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `research_site_initiative_92` tinyint(4) DEFAULT NULL,
  `it_system_93` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_research_site_initiative_92` (`research_site_initiative_92`),
  KEY `INDEX_it_system_93` (`it_system_93`)
);

DROP TABLE IF EXISTS `civicrm_value_genvasc_withdrawal_status_8`;

CREATE TABLE `civicrm_value_genvasc_withdrawal_status_8` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `withdrawal_status_24` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_withdrawal_status_24` (`withdrawal_status_24`)
 );

DROP TABLE IF EXISTS `civicrm_value_global_leaders_17`;

CREATE TABLE `civicrm_value_global_leaders_17` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `global_leaders_id_76` varchar(255) DEFAULT NULL,
  `treatment_arm_77` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_global_leaders_id_76` (`global_leaders_id_76`),
  KEY `INDEX_treatment_arm_77` (`treatment_arm_77`)
);

DROP TABLE IF EXISTS `civicrm_value_gp_site_based_data_4`;

CREATE TABLE `civicrm_value_gp_site_based_data_4` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `practice_ice_code_8` varchar(255) DEFAULT NULL,
  `practice_branch_code_54` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_practice_branch_code_54` (`practice_branch_code_54`),
  KEY `INDEX_practice_ice_code_8` (`practice_ice_code_8`)
);

DROP TABLE IF EXISTS `civicrm_value_gp_surgery_data_3`;

CREATE TABLE `civicrm_value_gp_surgery_data_3` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `practice_code_7` varchar(255) DEFAULT NULL,
  `practice_status_53` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_practice_code_7` (`practice_code_7`),
  KEY `INDEX_practice_status_53` (`practice_status_53`),
  KEY `dedupe_index_practice_code_7` (`practice_code_7`)
);

DROP TABLE IF EXISTS `civicrm_value_graphic2_9`;

CREATE TABLE `civicrm_value_graphic2_9` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `graphic_lab_id_25` varchar(255) DEFAULT NULL,
  `graphic_participant_id_26` varchar(255) DEFAULT NULL,
  `graphic_family_id_27` varchar(255) DEFAULT NULL,
  `consent_for_further_studies_28` tinyint(4) DEFAULT NULL,
  `g1_blood_consent_29` tinyint(4) DEFAULT NULL,
  `pre_consent_to_graphic_2_30` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_graphic_lab_id_25` (`graphic_lab_id_25`),
  KEY `INDEX_graphic_family_id_27` (`graphic_family_id_27`),
  KEY `INDEX_consent_for_further_studies_28` (`consent_for_further_studies_28`),
  KEY `INDEX_g1_blood_consent_29` (`g1_blood_consent_29`),
  KEY `INDEX_pre_consent_to_graphic_2_30` (`pre_consent_to_graphic_2_30`),
  KEY `INDEX_graphic_participant_id_26` (`graphic_participant_id_26`)
);

DROP TABLE IF EXISTS `civicrm_value_health_worker_data_2`;

CREATE TABLE `civicrm_value_health_worker_data_2` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `gp_gmc_number_3` varchar(255) DEFAULT NULL,
  `gp_practitioner_code_4` varchar(255) DEFAULT NULL,
  `gp_ice_code_5` varchar(255) DEFAULT NULL,
  `gcp_training_date_6` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_gp_practitioner_code_4` (`gp_practitioner_code_4`),
  KEY `dedupe_index_gp_practitioner_code_4` (`gp_practitioner_code_4`)
);

DROP TABLE IF EXISTS `civicrm_value_indapamide_26`;

CREATE TABLE `civicrm_value_indapamide_26` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `indapamide_id_112` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_indapamide_id_112` (`indapamide_id_112`)
);

DROP TABLE IF EXISTS `civicrm_value_interval_data_21`;

CREATE TABLE `civicrm_value_interval_data_21` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `interval_id_98` varchar(255) DEFAULT NULL,
  `consent_date_99` datetime DEFAULT NULL,
  `consent_version_100` varchar(255) DEFAULT NULL,
  `consent_leaflet_101` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_interval_id_98` (`interval_id_98`),
  KEY `INDEX_consent_date_99` (`consent_date_99`),
  KEY `INDEX_consent_version_100` (`consent_version_100`),
  KEY `INDEX_consent_leaflet_101` (`consent_leaflet_101`)
);

DROP TABLE IF EXISTS `civicrm_value_lenten_29`;

CREATE TABLE `civicrm_value_lenten_29` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `lenten_id_119` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_lenten_id_119` (`lenten_id_119`)
);

DROP TABLE IF EXISTS `civicrm_value_limb_35`;

CREATE TABLE `civicrm_value_limb_35` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `limb_id_129` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_limb_id_129` (`limb_id_129`)
);

DROP TABLE IF EXISTS `civicrm_value_national_bioresource_34`;

CREATE TABLE `civicrm_value_national_bioresource_34` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `national_bioresource_id_126` varchar(255) DEFAULT NULL,
  `leicester_bioresource_id_127` varchar(255) DEFAULT NULL,
  `legacy_bioresource_id_128` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_national_bioresource_id_126` (`national_bioresource_id_126`),
  KEY `INDEX_leicester_bioresource_id_127` (`leicester_bioresource_id_127`),
  KEY `INDEX_legacy_bioresource_id_128` (`legacy_bioresource_id_128`)
);

DROP TABLE IF EXISTS `civicrm_value_next_of_kin_data_7`;

CREATE TABLE `civicrm_value_next_of_kin_data_7` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `next_of_kin__name_21` varchar(255) DEFAULT NULL,
  `next_of_kin__relationship_22` varchar(255) DEFAULT NULL,
  `next_of_kin__telephone_number_23` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`)
);

DROP TABLE IF EXISTS `civicrm_value_nihr_bioresource_11`;

CREATE TABLE `civicrm_value_nihr_bioresource_11` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `nihr_bioresource_id_41` varchar(255) DEFAULT NULL,
  `date_of_consent_42` datetime DEFAULT NULL,
  `nihr_bioresource_consent_q1_43` tinyint(4) DEFAULT NULL,
  `nihr_bioresource_consent_q2_44` tinyint(4) DEFAULT NULL,
  `nihr_bioresource_consent_q3_45` tinyint(4) DEFAULT NULL,
  `nihr_bioresource_consent_q4_46` tinyint(4) DEFAULT NULL,
  `nihr_bioresource_consent_q5_47` tinyint(4) DEFAULT NULL,
  `nihr_bioresource_consent_q6_48` tinyint(4) DEFAULT NULL,
  `nihr_bioresource_legacy_id_78` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_date_of_consent_42` (`date_of_consent_42`),
  KEY `INDEX_nihr_bioresource_consent_q1_43` (`nihr_bioresource_consent_q1_43`),
  KEY `INDEX_nihr_bioresource_consent_q2_44` (`nihr_bioresource_consent_q2_44`),
  KEY `INDEX_nihr_bioresource_consent_q3_45` (`nihr_bioresource_consent_q3_45`),
  KEY `INDEX_nihr_bioresource_consent_q4_46` (`nihr_bioresource_consent_q4_46`),
  KEY `INDEX_nihr_bioresource_consent_q5_47` (`nihr_bioresource_consent_q5_47`),
  KEY `INDEX_nihr_bioresource_consent_q6_48` (`nihr_bioresource_consent_q6_48`),
  KEY `INDEX_nihr_bioresource_id_41` (`nihr_bioresource_id_41`),
  KEY `INDEX_nihr_bioresource_legacy_id_78` (`nihr_bioresource_legacy_id_78`)
);

DROP TABLE IF EXISTS `civicrm_value_nihr_bioresource_withdrawal_12`;

CREATE TABLE `civicrm_value_nihr_bioresource_withdrawal_12` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `nihr_bioresource_withdrawal_stat_49` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_nihr_bioresource_withdrawal_stat_49` (`nihr_bioresource_withdrawal_stat_49`)
);

DROP TABLE IF EXISTS `civicrm_value_omics_register_20`;

CREATE TABLE `civicrm_value_omics_register_20` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `omics_type_94` varchar(255) DEFAULT NULL,
  `sample_source_study_95` varchar(255) DEFAULT NULL,
  `failed_qc_96` tinyint(4) DEFAULT NULL,
  `date_data_received_97` datetime DEFAULT NULL,
  `omics_id_102` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_omics_type_94` (`omics_type_94`),
  KEY `INDEX_sample_source_study_95` (`sample_source_study_95`),
  KEY `INDEX_failed_qc_96` (`failed_qc_96`),
  KEY `INDEX_date_data_received_97` (`date_data_received_97`),
  KEY `INDEX_omics_id_102` (`omics_id_102`)
);

DROP TABLE IF EXISTS `civicrm_value_predict_30`;

CREATE TABLE `civicrm_value_predict_30` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `predict_id_121` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_predict_id_121` (`predict_id_121`)
);

DROP TABLE IF EXISTS `civicrm_value_preeclampsia_33`;

CREATE TABLE `civicrm_value_preeclampsia_33` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `preeclampsia_id_125` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_preeclampsia_id_125` (`preeclampsia_id_125`)
);

DROP TABLE IF EXISTS `civicrm_value_scad_15`;

CREATE TABLE `civicrm_value_scad_15` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `scad_id_58` varchar(255) DEFAULT NULL,
  `consent_read_information_59` tinyint(4) DEFAULT NULL,
  `consent_understands_withdrawal_60` tinyint(4) DEFAULT NULL,
  `consent_provide_medical_informat_61` tinyint(4) DEFAULT NULL,
  `consent_contact_by_research_team_62` tinyint(4) DEFAULT NULL,
  `consent_sample_storage_63` tinyint(4) DEFAULT NULL,
  `consent_no_financial_benefit_64` tinyint(4) DEFAULT NULL,
  `consent_contact_gp_65` tinyint(4) DEFAULT NULL,
  `consent_dna_sequencing_66` tinyint(4) DEFAULT NULL,
  `consent_skin_biopsy_67` tinyint(4) DEFAULT NULL,
  `consent_understands_how_to_conta_68` tinyint(4) DEFAULT NULL,
  `consent_share_information_with_m_69` tinyint(4) DEFAULT NULL,
  `consent_access_to_medical_record_70` tinyint(4) DEFAULT NULL,
  `consent_contact_for_related_stud_71` tinyint(4) DEFAULT NULL,
  `consent_receive_research_sumary_72` tinyint(4) DEFAULT NULL,
  `consent_date_73` datetime DEFAULT NULL,
  `briccs_id_88` varchar(255) DEFAULT NULL,
  `survey_reference_89` varchar(255) DEFAULT NULL,
  `scad_visit_id_90` varchar(255) DEFAULT NULL,
  `recruitment_type_91` varchar(255) DEFAULT NULL,
  `2nd_scad_survey_id_105` varchar(255) DEFAULT NULL,
  `scad_registry_id_120` varchar(255) DEFAULT NULL,
  `family_id_122` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_scad_id_58` (`scad_id_58`),
  KEY `INDEX_consent_read_information_59` (`consent_read_information_59`),
  KEY `INDEX_consent_understands_withdrawal_60` (`consent_understands_withdrawal_60`),
  KEY `INDEX_consent_provide_medical_informat_61` (`consent_provide_medical_informat_61`),
  KEY `INDEX_consent_contact_by_research_team_62` (`consent_contact_by_research_team_62`),
  KEY `INDEX_consent_sample_storage_63` (`consent_sample_storage_63`),
  KEY `INDEX_consent_no_financial_benefit_64` (`consent_no_financial_benefit_64`),
  KEY `INDEX_consent_contact_gp_65` (`consent_contact_gp_65`),
  KEY `INDEX_consent_dna_sequencing_66` (`consent_dna_sequencing_66`),
  KEY `INDEX_consent_skin_biopsy_67` (`consent_skin_biopsy_67`),
  KEY `INDEX_consent_understands_how_to_conta_68` (`consent_understands_how_to_conta_68`),
  KEY `INDEX_consent_share_information_with_m_69` (`consent_share_information_with_m_69`),
  KEY `INDEX_consent_access_to_medical_record_70` (`consent_access_to_medical_record_70`),
  KEY `INDEX_consent_contact_for_related_stud_71` (`consent_contact_for_related_stud_71`),
  KEY `INDEX_consent_receive_research_sumary_72` (`consent_receive_research_sumary_72`),
  KEY `INDEX_consent_date_73` (`consent_date_73`),
  KEY `INDEX_briccs_id_88` (`briccs_id_88`),
  KEY `INDEX_survey_reference_89` (`survey_reference_89`),
  KEY `INDEX_scad_visit_id_90` (`scad_visit_id_90`),
  KEY `INDEX_recruitment_type_91` (`recruitment_type_91`),
  KEY `INDEX_2nd_scad_survey_id_105` (`2nd_scad_survey_id_105`),
  KEY `INDEX_scad_registry_id_120` (`scad_registry_id_120`),
  KEY `INDEX_family_id_122` (`family_id_122`)
);

DROP TABLE IF EXISTS `civicrm_value_scad_register_37`;

CREATE TABLE `civicrm_value_scad_register_37` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `scad_registry_id_131` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_scad_registry_id_131` (`scad_registry_id_131`)
);

DROP TABLE IF EXISTS `civicrm_value_spiral_32`;

CREATE TABLE `civicrm_value_spiral_32` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `spiral_id_124` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_spiral_id_124` (`spiral_id_124`)
);

DROP TABLE IF EXISTS `civicrm_value_tmao_18`;

CREATE TABLE `civicrm_value_tmao_18` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Default MySQL primary key',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Table that this extends',
  `tmao_id_79` varchar(255) DEFAULT NULL,
  `tmao_consent_has_read_informatio_80` tinyint(4) DEFAULT NULL,
  `tmao_consent_understands_withdra_81` tinyint(4) DEFAULT NULL,
  `tmao_consent_permission_to_acces_82` tinyint(4) DEFAULT NULL,
  `tmao_consent_gp_informed_83` tinyint(4) DEFAULT NULL,
  `tmao_consent_to_enrol_84` tinyint(4) DEFAULT NULL,
  `tmao_consent_to_store_blood_85` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_id` (`entity_id`),
  KEY `INDEX_tmao_id_79` (`tmao_id_79`),
  KEY `INDEX_tmao_consent_has_read_informatio_80` (`tmao_consent_has_read_informatio_80`),
  KEY `INDEX_tmao_consent_understands_withdra_81` (`tmao_consent_understands_withdra_81`),
  KEY `INDEX_tmao_consent_permission_to_acces_82` (`tmao_consent_permission_to_acces_82`),
  KEY `INDEX_tmao_consent_gp_informed_83` (`tmao_consent_gp_informed_83`),
  KEY `INDEX_tmao_consent_to_enrol_84` (`tmao_consent_to_enrol_84`),
  KEY `INDEX_tmao_consent_to_store_blood_85` (`tmao_consent_to_store_blood_85`)
);

DROP TABLE IF EXISTS `civicrm_website`;

CREATE TABLE `civicrm_website` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Website ID',
  `contact_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Contact ID',
  `url` varchar(128) DEFAULT NULL COMMENT 'Website',
  `website_type_id` int(10) unsigned DEFAULT NULL COMMENT 'Which Website type does this website belong to.',
  PRIMARY KEY (`id`),
  KEY `UI_website_type_id` (`website_type_id`),
  KEY `FK_civicrm_website_contact_id` (`contact_id`)
);

DROP TABLE IF EXISTS `civicrm_word_replacement`;

CREATE TABLE `civicrm_word_replacement` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Word replacement ID',
  `find_word` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'Word which need to be replaced',
  `replace_word` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'Word which will replace the word in find',
  `is_active` tinyint(4) DEFAULT 1 COMMENT 'Is this entry active?',
  `match_type` varchar(16) DEFAULT 'wildcardMatch',
  `domain_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to Domain ID. This is for Domain specific word replacement',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_domain_find` (`domain_id`,`find_word`)
);

DROP TABLE IF EXISTS `civicrm_worldregion`;

CREATE TABLE `civicrm_worldregion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Id',
  `name` varchar(128) DEFAULT NULL COMMENT 'Region name to be associated with countries',
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `genvasc_invoice_import`;

CREATE TABLE `genvasc_invoice_import` (
  `year` int(11) DEFAULT NULL,
  `quarter` int(11) DEFAULT NULL,
  `practice_code` varchar(50) DEFAULT NULL,
  `gpt_number` varchar(50) DEFAULT NULL,
  `recruited_date` date DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL
);

DROP TABLE IF EXISTS `genvasc_invoice_import_distinct`;

CREATE TABLE `genvasc_invoice_import_distinct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` int(11) DEFAULT NULL,
  `quarter` int(11) DEFAULT NULL,
  `practice_code` varchar(50) DEFAULT NULL,
  `gpt_number` varchar(50) DEFAULT NULL,
  `recruited_date` date DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `case_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_gpt_number` (`gpt_number`)
);

DROP TABLE IF EXISTS `gii_cases`;

CREATE TABLE `gii_cases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gii_id` int(11) DEFAULT NULL,
  `case_id` int(11) DEFAULT NULL,
  `reimbursed` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `gii_superceded`;

CREATE TABLE `gii_superceded` (
  `gii_id` int(11) DEFAULT NULL
);

DROP TABLE IF EXISTS `giic_multi_cases`;

CREATE TABLE `giic_multi_cases` (
  `giic_id` int(11) DEFAULT NULL
);

DROP TABLE IF EXISTS `lbrc_recruitment_audit`;

CREATE TABLE `lbrc_recruitment_audit` (
  `case_id` int(11) NOT NULL,
  `last_change_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`case_id`)
);

DROP TABLE IF EXISTS `rab_moveActivityTypes_20151009`;

CREATE TABLE `rab_moveActivityTypes_20151009` (
  `activity_id` int(11) DEFAULT NULL,
  `activity_type_id` int(11) DEFAULT NULL
);

DROP TABLE IF EXISTS `submitted`;

CREATE TABLE `submitted` (
  `gpt` varchar(30) DEFAULT NULL,
  UNIQUE KEY `submitted_gpt_index` (`gpt`)
);

DROP TABLE IF EXISTS `submittedActivities`;

CREATE TABLE `submittedActivities` (
  `activityID` int(11) DEFAULT NULL,
  `gpt` varchar(30) DEFAULT NULL,
  KEY `submittedActivities_gpt` (`gpt`),
  KEY `submittedActivities_activityID` (`activityID`)
);
