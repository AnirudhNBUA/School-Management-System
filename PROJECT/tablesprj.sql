create table Admin_Dept(
AD_ID number(5) constraint admin_pk primary key,
NAME varchar(20) not null,
Designation varchar(20) not null,
qualification varchar(10) not null,
email varchar(20) not null,
phone number(10) not null,
salary number(5));


create table student(
roll_no number(5) constraint roll_pk primary key,
name varchar(20) constraint n_null not null,
class number(2),
section varchar(2), fees varchar(10));


create table Teacher(
t_id varchar(10) constraint t_id_pk primary key,
name varchar(20) constraint name_nnull not null,
Qualification varchar(10),
salary number(5),
std_sec varchar(5),
phone_no number(10),
Ad_id number(5),
constraint teacher_adid_fk foreign key(AD_ID) references Admin_Dept(AD_ID));

Create table Exam(
Exam_code varchar(10) constraint ex_cd_pk primary key,
Exam_sub varchar(10) constraint ex_sb_nnull not null,
Exam_date date,
Exam_qpaper varchar(20),
T_ID varchar(10),
Constraint ex_fk foreign key(T_ID) references teacher(T_ID));

Create table subjects(
Subj_code varchar(10) constraint sub_code_pk primary key,
Name varchar(100) constraint subn_nnull not null,
T_ID varchar(10),
Tot_stud_enrol number(5),
Constraint subt_fk foreign key(T_ID) references teacher(T_ID));

Create table Homework(
Hw_id varchar(10) constraint hw_id_pk primary key,
Sub_assign varchar(10) constraint sub_nnull not null,
T_ID varchar(10),
Due_date date,
No_of_students number(3),
Constraint hw_fk foreign key(T_ID) references teacher(T_ID));

Create table Class(
Std_sec varchar(5) constraint std_sc_pk primary key,
AD_ID number(5),
t_id varchar(10),
Total_students number(10) constraint ts_nnull not null,
Constraint cl_ad_fk foreign key(AD_ID) references Admin_Dept(AD_ID),
CONSTRAINT C_T_FK foreign key(t_id) references Teacher(t_id));

Create table marks(
Paper_No varchar(10) constraint mark_pk primary key,
Marks_obt number(3) constraint mk_obt_nnull not null,
Total_marks number(3),
Subject varchar(100),
Student_name varchar(100),
T_ID varchar(10),
Roll_No number(5),
Constraint mk_fk1 foreign key(T_ID) references teacher(T_ID),
Constraint mk_fk2 foreign key(Roll_No) references student(Roll_No));


Create table parent(
roll_no number(5) CONSTRAINT wk primary key references student ON DELETE CASCADE,
Parent_name varchar(100),
Phone_No number(10));