---
title: "Goat VMS"
description: "GoatVMS was a volunteer management system. This page provides minimal documentation and schemas."
slug: ""
image: ""
keywords: ""
date: 2020-05-01T12:02:56-05:00
aliases: ""
expiryDate: ""
layout: ""
include_toc: true
show_comments: false
draft: false
weight: 10
---

## GoatVMS Data Schemes

Many of the data schemes are derived from HR-XML Consortium, new branding is [HR Open Standards](https://hropenstandards.org/).

Local file is file:///d:/Downloads/XML/Specifications/HR-XML-2004-08/HR-XML-2_3/index.html. Review Consortium Approved Shared Components (CPOs) section first.

### Table Design

Each descriptor has a main table defined for it unless otherwise noted. Some of the fields within the descriptors tables may have mutliple values and these are stored in a sub-table.

```
CREATE TABLE `sub_TableName` (
  `subID` mediumint(8) unsigned NOT NULL auto_increment,
  `mainID` mediumint(8) unsigned NOT NULL default '0',
  `fieldName` varchar(100) NOT NULL default '',
  `fieldValue` text NOT NULL,
  `isDefault` smallint(2) NOT NULL default '0',
  PRIMARY KEY  (`subID`),
  KEY `PersonNameID` (`mainID`,`fieldName`)
)
```

### CPO

#### Person Name

*   PersonName.html
    *   PersonName.xsd

#### Competencies

*   Competencies.html
    *   Competencies.xsd
    *   Competencies-CommunicationSkills.xml
    *   Competencies-DriversLicense.xml
    *   Competencies-Education.xml
    *   Competencies-Language.xml
    *   Competencies-Observe.xml
    *   Competencies-ONet.xml
    *   Competencies-YearsAndTestScore.xml
    *   LanguagesExample.xml

#### Contact Method

*   ContactMethod.html
    *   ContactMethod.xsd

#### Date Time Data Types

*   DateTimeDataTypes.html
    *   DateTimeDataTypes.xsd
    *   EffectiveDating.html
    *   Frequencies.xsd

#### Person Descriptors

*   PersonDescriptors.html
    *   PersonDescriptors.xsd
    *   DemographicDetail.xsd

#### Education History

*   EducationHistory.html
    *   EducationHistory.xsd
    *   EducationExample1.xml
    *   EducationExample2.xml

#### Employment History

*   EmploymentHistory.html
    *   EmploymentHistory.xsd
    *   EmploymentExample1.xml
    *   EmploymentExample2.xml

#### Job and Position

*   JobAndPositionHeader.html
    *   JobHeader.xsd
    *   JobHeaderExample.xml

#### Useful Reference

*   IdentifierTypes.html
    *   IdentifierTypes.xsd
    *   EntityIdentifiers.html


## Basic Descriptors

### Person Name

Person Name covers most possible variations of a a persons name. Some of the fields will be required and some will be optional.

|Name|Type|Null allowed|Default|Description|Example|
|--- |--- |--- |--- |--- |--- |
|PersonNameID|mediumint(8) unsigned|No||autoincrement|12|
|FormattedName|varchar(250)|No||Contains, in one string, a fully formatted name with all of its pieces in their proper place. This includes all of the necessary punctuation.|Dr. Jerry R. Jones, M.D.|
|LegalName|varchar(250)|Yes|NULL|Legal name used for legal documentation or other legal purposes. Contains, in one string, a fully formatted name with all of its pieces in their proper place. This includes all of the necessary punctuation.|Jeremiah Reginald Jones|
|GivenName|varchar(60)|Yes|NULL|Contains the given or chosen name. Also known as a person’s first name. If multiple givenNames are used, the order is implied.|Jeremiah|
|PreferredGivenName|varchar(60)|Yes|NULL|Contains the chosen name by which the person prefers to be addressed. Note: This name may be a name other than a given name, such as a nickname.|Dr. Jerry|
|MiddleName|varchar(60)|Yes|NULL|Contains a person’s middle name or initial.|R.|
|FamilyName|varchar(100)|No||Contains the non-chosen or inherited name. Also known as a person’s last name in the Western context.|Jones|
|Affix_aristocraticTitle|varchar(30)|Yes|NULL|Aristocratic Title|Baron|
|Affix_formOfAddress|varchar(30)|Yes|NULL|Contains the Salutation|Mr., Dr.|
|Affix_generation|varchar(30)|Yes|NULL|Generation|Sr., Jr., III|
|Affix_qualification|varchar(30)|Yes|NULL|Academic or other quialification|PhD, MD, CPA, MCSD|

Fields which may have mutliple occurances are contained in the PersonName_sub table.


### Postal Address

Describes a postal address used for delivery of mail. Some of the fields will be required and some will be optional.

|Name|Type|Required/ Allowed|Default|Description|Example|
|--- |--- |--- |--- |--- |--- |
|PostalAddressID|mediumint(8) unsigned|1/1||autoincrement|12|
|RecipientID|mediumint(8) unsigned|1/1||Links to person, organization, or household|Roland McDonald|
|CountryCode|varchar(250)|1/1|US|Contains the ISO 3166-1 two-character country code.|US|
|PostalCode|CountryCodeType|0/1|NULL|Codes established by postal authorities for purposes of sorting and delivering mail.|53205|
|Region|varchar(60)|0/*|NULL|Represents the State, Province, and/or County. Military addresses should be stored in multiple regions (hierarchy region from highest to most specific): 1 st region = APO (Army/Airforce Post Office); FPO (Fleet Post Office). 2 nd region = 2 letter designator for part of world (AE Europe, AA Americas)|Wisconsin|
|Municipality|varchar(60)|0/1|NULL|Represents the city, town, village, or hamlet.|Milwaukee|
|AddressLine|varchar(100)|0/*|NULL|AddressLine is used for delivery by the postal service. May contain the name or number of the building, house, and/or street.|5223 Oak Street; 213; East 23rd Avenue; P.O. Box 241; Suite 200|
|Unit|varchar(30)|0/1|NULL|Contains the Apartment, Suite, Unit, Room, Floor, Trailer, Level, Hanger, etc.|Apt. 24|
|PostOfficeBox|varchar(30)|0/1|NULL|Contains the Post Office Box.|P.O. Box 312|
|RoutingText|varchar(30)|0/*|NULL|Routing information in addition to organization and person name|attn: Tom Wave|

### Organization

Contains information about the organization.

|Name|Type|Required/ Allowed|Default|Description|Example|
|--- |--- |--- |--- |--- |--- |
|OrganizationID|mediumint(8) unsigned|1/1||autoincrement|12|
|OrganizationName|varchar(250)|1/1||The official name by which an organization or enterprise is known.|K & K Resources, LLP.|
|TaxId|varchar(30)|0/*|NULL|Taxing authority issued ID|97-66972|
|LegalId|varchar(30)|0/*|NULL|A unique legal identifier for an entity|5698432|
|DunsNumber|varchar(9)|0/*|NULL|A nine digit identifier issued by Dun and Bradstreet.|123456789|
|InternetDomainName|varchar(60)|0/*|NULL|Internet domain name of the organization|microsoft.com|
|DoingBusinessAs|varchar(60)|0/*|NULL|The name by which an organization or enterprise is commonly known in the capacity of conducting business transactions within a geographical area.|SBC|
|LegalClassification|varchar(60)|0/*|NULL|The name of a business structure classification legally recognized in the country designated by the country attribute.|C Corporation, Sole Proprietorship|
|IndustryCode|varchar(10)|0/*|||12|
|Headcount|varchar(20)|0/*|||12|
|Description|varchar(60)|0/1|||12|
|WorkSite|varchar(30)|0/*|||12|
|ContactInfo|varchar(8)|0/*|||12|
|RelatedOrganization|varchar(8)|0/*|||12|
|OrganizationalUnit|varchar(8)|0/*|||12|
|UserArea|varchar(8)|0/*|||12|


#### Organization Sub-table

|Name|Type|Required/ Allowed|Default|Description|Example|
|--- |--- |--- |--- |--- |--- |
|SubID|mediumint(8) unsigned|1/1|autoincrement||12|
|OrganizationID|mediumint(8) unsigned|1/1|ref||12|
|FieldName|varchar(30)|1/1|||TaxID|
|FieldValue|varchar(60)|1/1|||12|
|primaryIndicator|varchar(8)|11|||TRUE|
|WorkSite|varchar(8)|0/*|||12|



## PersonDescriptors

### Legal Identifiers

A collection of legal identifiers for a person. Some of the fields will be required and some will be optional.

|Name|Type|Null allowed|Default|Description|Example|
|--- |--- |--- |--- |--- |--- |
|LegalID|mediumint(8) unsigned|No||autoincrement|12|
|PersonLegalId|varchar(250)|Yes|NULL|A unique government or other legal identifier for a person|MMM-875678|
|LegalID_countryCode|CountryCodeType|Yes|NULL|Contains the ISO 3166-1 two-character country code.|US|
|LegalID_jurisdiction|varchar(60)|Yes|NULL|Specifies the geographical area of the issuing authority.|Wisconsin|
|LegalID_issuingRegion|varchar(60)|Yes|NULL|Defines the region where the issuing authority is located.||
|LegalID_documentType|varchar(100)|No||Specifies the type of document tied to the ID.|Drivers license|
|LegalID_idSource|varchar(30)|Yes|NULL|The actual source that is reporting the ID.||
|MilitaryStatus|varchar(30)|Yes|NULL|Defines whether the person is currently a member of the military, or other specific information regarding military status.|Veteran|
|VisaStatus|varchar(30)|Yes|NULL|Describes the person's visa status.|H1B|
|LegalID_countryCode|CountryCodeType|Yes|NULL|Contains the ISO 3166-1 two-character country code.|TW|
|LegalID_validFrom|varchar(60)|Yes|NULL|The date the event begins, is active or valid.|12-25-2004|
|LegalID_validTo|varchar(60)|Yes|NULL|The date through which the event is active or valid.|12-25-2008|
|Citizenship|CountryCodeType|Yes|NULL|Contains the ISO 3166-1 two-character country code where a person retains legal citizenship.|TW|
|Residency|CountryCodeType|Yes|NULL|Contains the ISO 3166-1 two-character country code where a person maintains their current residence.|US|


### Demographic Descriptors

A collection of demographic descriptors for a person. Some of the fields will be required and some will be optional.

|Name|Type|Null allowed|Default|Description|Example|
|--- |--- |--- |--- |--- |--- |
|DemographicID|mediumint(8) unsigned|No||autoincrement|12|
|Race|varchar(250)|Yes|NULL|Describes the race of the person. May be more than 1.|Asian, EEOC Code|
|Ethnicity|varchar(60)|Yes|NULL|The ethnicity of the person. May be more than 1.|Chinese|
|Nationality|varchar(60)|Yes|NULL|The ISO 3166-1 two-character country code for belonging to a particular nation by origin, birth, or naturalization.|US|
|PrimaryLanguage|varchar(60)|Yes|NULL|Primary language of the person.|French|
|AdditionalLanguages|varchar(60)|Yes|NULL|Additional language spoken by the person.|Mandarin, English|
|BirthPlace|varchar(100)|No||The birth place of the person.|Dallas, TX, US|
|Religion|varchar(30)|Yes|NULL|The religion of the person|Jainism|
|MaritalStatus|varchar(30)|Yes|NULL|The marital status of the person.|Domestic Partner, Divorced, Married, Unreported, Separated, Unmarried, Widowed, Legally Separated|
|NumberOfChildren|varchar(30)|Yes|NULL|the number of children for the person.|3|
|ChildrenComments|varchar(60)|Yes|NULL|Comments regarding the person's children. This may include age, sex, etc.|Ages:3,5,7|


### Biological Descriptors

A collection of biological descriptors for a person. Some of the fields will be required and some will be optional.

|Name|Type|Null allowed|Default|Description|Example|
|--- |--- |--- |--- |--- |--- |
|BiologicalID|mediumint(8) unsigned|No||autoincrement|12|
|DateOfBirth|varchar(250)|Yes|NULL|A person's birth date.|10/08/2002|
|GenderCode|varchar(60)|Yes|NULL|Describes the sex of the person based on representation of human sexes. Representation of human sexes values are represented in accordance with ISO 5218.|0 = None; 1 = Male; 2 = Female; 9 = None Specified|
|EyeColor|varchar(60)|Yes|NULL|The person's eye color.|Black, Hazel, Gray, Brown, Violet, Green, Blue, Maroon, Pink, Dichromatic, Unknown|
|HairColor|varchar(60)|Yes|NULL|The person's hair color.|Bald, Brown, White, Blonde, Gray, Red, Auburn, Black, Silver, Unknown|
|Height|varchar(100)|No||The height of a person.|5.9|
|Height_unitOfMeasure|varchar(30)|Yes|NULL|Unit of measure|Feet|
|Weight|varchar(30)|Yes|NULL|The weight of a person.|175|
|Weight_unitOfMeasure|varchar(30)|Yes|NULL|Unit of measure|Pounds|
|IdentifyingMarks|varchar(30)|Yes|NULL|Description of any identifying marks on a person.|Dagger tatoo right arm.|
|DisabilityInfo|varchar(60)|Yes|NULL|Contains information about a person's physical or psychological impairment.|Wheelchair due to muscle degeneration.|
|AccommodationsNeeded|varchar(60)|Yes|NULL|Indicates any special accommodations needed in the workplace.|Regular breaks|

#### Additional Biological Descriptors

|Name|Type|Null allowed|Default|Description|Example|
|--- |--- |--- |--- |--- |--- |
|BiologicalID|mediumint(8) unsigned|No||from Biological Descriptors|12|
|OtherBioID|mediumint(8) unsigned|No||autoincrement|12|
|DescName|varchar(60)|No||Name of user created descriptor|Shoe size|
|DescValue|varchar(60)|Yes|NULL|Value of the user created descriptor|10|


## Track Changes Within the Database

Two tables are used to track changes (audit) made to data fields within goatVMS. These are borrowed from the excellent work done by [Tony Marston](http://www.tonymarston.net/php-mysql/auditlog.html). The two tables are AUDIT_HDR and AUDIT_DTL. They are defined thusly.

### AUDIT_HDR

```
CREATE TABLE `audit_hdr` (
  `session_id` varchar(32) NOT NULL default '',
  `tran_seq_no` smallint(6) NOT NULL default '0',
  `user_id` varchar(16) default NULL,
  `date` date NOT NULL default '0000-00-00',
  `time` time NOT NULL default '00:00:00',
  `task_id` varchar(32) default NULL,
  PRIMARY KEY  (`session_id`,`tran_seq_no`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM;
```

|||
|--- |--- |
|SESSION_ID|A unique number given to each session as the user passes through the logon screen.|
|TRAN_SEQ_NO|Transaction Sequence Number. This starts at 1 for each Session.
Each time the database is updated - when the user presses the SUBMIT  button which initiates a start transaction and ends with a commit - this is treated as a separate Transaction. This may include any number of database additions, deletions and updates.|
|USER_ID|User identity. This links to the USER table in my *Role Based Access Control database*.|
|DATE|The date the Transaction started.|
|TIME|The time the Transaction started.|
|TASK_ID|The name of the component from which the user initiated the transaction. This links to the TASK table in my *Role Based Access Control database*.|

### AUDIT_DTL

```
CREATE TABLE `audit_dtl` (
  `session_id` varchar(32) NOT NULL default '',
  `tran_seq_no` smallint(6) NOT NULL default '0',
  `table_seq_no` smallint(6) NOT NULL default '0',
  `base_name` varchar(32) default NULL,
  `table_name` varchar(32) default NULL,
  `pkey` varchar(255) default NULL,
  `before_data` text,
  `after_data` text,
  PRIMARY KEY  (`session_id`,`tran_seq_no`,`table_seq_no`)
) ENGINE=MyISAM;
```

|||
|--- |--- |
|SESSION_ID|As above|
|TRAN_SEQ_NO|As above.|
|TABLE_SEQ_NO|Table Sequence Number. This starts at 1 for each Transaction.
There may be changes to several occurrences of the same table, so each occurrence is given its own sequence number.|
|BASE_NAME|Database Name. An application may have more than one database, and it is possible for the same table name to exist in more than one database.|
|TABLE_NAME|Table Name. The name of the database table being updated.|
|PKEY|Primary Key. The primary key of the database record, shown in the format of the WHERE clause of an sql SELECT statement, as in field='value' AND field='value'.|
|BEFORE_DATA|An associative array of name=value pairs showing field values before the database update.|
|AFTER_DATA|An associative array of name=value pairs showing field values after the database update.|
