set SERVEROUTPUT ON;

create or replace procedure fee_details is
cursor ta is select roll_no,name,fees from student;
s_roll number(4);
s_name varchar(15);
s_fee varchar(10);
begin
open ta;
loop
fetch ta into s_roll,s_name,s_fee;
exit when ta%notfound;
dbms_output.put_line(s_roll || ' ' || s_name ||' ' || s_fee);
end loop;
close ta;
end;

exec fee_details;




create or replace procedure t_name(Sub_code varchar) is
cursor tn is select name from TEACHER where t_id in(select T_ID from subjects where Subj_code=sub_code);
teacher_name TEACHER.name%type;
begin
for t_rec in tn loop
teacher_name:=t_rec.name;
dbms_output.put_line('teacher name is :' ||teacher_name);
end loop;
end;
/

exec t_name('CHY1001');


create or replace function totalSt 
return integer 
as 
total integer:=0; 

begin                         
select count(roll_no) into total from student where fees='PAID';  
return total; 
end totalSt; 

declare 
answer integer; 

begin 
answer:=totalst(); 
   dbms_output.put_line('total number of students paid is  ' || answer);   
end;







create or replace function num_student(student_sec varchar)

return number
as
cal number;

begin                         
select Total_students into cal from Class where  Std_sec=student_sec;  
return cal; 
end num_student; 

declare 
ans number; 

begin 
ans:=num_student('12A'); 
   dbms_output.put_line('no of studens in this class are  ' || ans);   
end;




/*Triggers*/
create or replace trigger trg_af_up_t 
after update of t_id on TEACHER
referencing new as new old as old
for each row
begin
update Class set t_id=:new.t_id where t_id =:old.t_id;
update Exam set T_ID=:new.t_id where T_ID =:old.t_id;
update Homework set T_ID=:new.t_id where T_ID =:old.t_id;
update marks set T_ID=:new.t_id where T_ID =:old.t_id;
update subjects set T_ID=:new.t_id where T_ID =:old.t_id;
end;

update TEACHER set t_id='PMT013' where t_id='PMT001';

select * from exam;
select * from class;
select * from marks;
select * from subjects;




Create table can_Exam(
Exam_code varchar(10) primary key,
Exam_sub varchar(10),
Exam_date date,
Exam_qpaper varchar(20),
T_ID varchar(10));

create or replace trigger exm_det
after delete on Exam
referencing new as new old as old
for each row
begin
insert into can_Exam 
values(:old.Exam_code,:old.Exam_sub,:old.Exam_date,:old.Exam_qpaper,:old.T_ID);
dbms_output.put_line('the exam is cancelled' || :old.Exam_code);
end;

delete Exam where Exam_code='EXM004';
delete exam where exam_code='EXM003'; 

select * from can_exam;





create or replace trigger trg_stud_upd 
after update of roll_no on student
referencing new as new old as old
for each row
begin
update marks set Roll_No=:new.roll_No where Roll_No=:old.roll_no;
update parent set roll_no=:new.roll_no where roll_no=:old.roll_no;
end;

update student set roll_no=50 where roll_no=14; 
select * from parent;
select * from marks;








