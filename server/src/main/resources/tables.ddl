

create table user (
	id bigint(20) auto_increment,
    token varchar(500) not null,
    device_token varchar(500) not null,
    nickname varchar(100) not null,
    created_date timestamp not null,
    last_modified_date timestamp not null,
    last_visited timestamp not null,
    noti_yn tinyint(1) not null,
    primary key(`id`),
    unique index (`token`)
);

create table dday (
	id bigint(20) auto_increment,
    token varchar(500) not null,
    title varchar(100) not null,
    emoji varchar(500) not null,
    dday_datetime timestamp not null,
    place varchar(500),
    color varchar(100),
    dday_type varchar(100),
    dday_description varchar(1000),
    registered_ymdt timestamp not null,
    updated_ymdt timestamp not null,

    primary key(`id`),
    index index_title(`title`),
    index index_dday_datetime(`dday_datetime`),
    index index_dday_description(`dday_description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

create table tag(
    id bigint(20) auto_increment,
    name varchar(50) not null,
    dday_id bigint(20) not null,
    primary key (`id`),
    index index_dday_id (`dday_id`),
    index index_name (`name`)
);

create table comment(
    id bigint(20) auto_increment,
    user_token varchar(500) not null,
    comment varchar(300) not null,
    created_date timestamp not null,
    last_modified_date timestamp not null,
    dday_id bigint(20) not null,

    primary key (`id`),
    index index_dday_id (`dday_id`),
    index index_comment (`comment`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

create table dday_follow(
    id bigint(20) auto_increment,
    user_token varchar(500) not null,
    dday_id bigint(20) not null,
    primary key (`id`),
    index index_user_token (`user_token`),
    unique (`user_token`, `dday_id`)
)

create table dday_report(
    id bigint(20) auto_increment,
    user_token varchar(500) not null,
    dday_id bigint(20) not null,
    primary key (`id`),
    index index_dday_id (`dday_id`),
    unique (`user_token`, `dday_id`)
);

create table comment_report(
    id bigint(20) auto_increment,
    user_token varchar(500) not null,
    comment_id bigint(20) not null,
    primary key (`id`),
    index index_comment_id (`comment_id`),
    unique (`user_token`, `comment_id`)
);