-- create tables
CREATE TABLE training.categories (
	training_id INT IDENTITY (1, 1) PRIMARY KEY,
               training_name VARCHAR (255) NOT NULL
);
CREATE TABLE curriculum.vendors (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
               brand_name VARCHAR (255) NOT NULL
);
CREATE_TABLE curriculum.subjects (
	course_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	branch_id INT NOT NULL,
	training_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	class_hours DECIMAL (10,2) NOT NULL, 
	FOREIGN KEY (training_id) REFERENCES curriculum.categories (training_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES curriculum.vendors (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE courses.students (
	student_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR(25),
	email VARCHAR (255) NOT NULL,
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);
CREATE TABLE courses.locations (
	location_id INT IDENTITY (1, 1) PRIMARY KEY,
	location_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255), 
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);
CREATE TABLE courses.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	location_id INT NOT NULL,
	instructor_id INT,
	FOREIGN KEY (location_id) REFERENCES courses.locations (location_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (instructor_id) REFERENCES courses.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE courses.registrations (
	registration_id INT IDENTITY (1, 1) PRIMARY KEY,
	student_id INT,
	registration_status tinyint NOT NULL,
	-- Registration status: 1 = Pending; 2 = Enrolled; 3 = Rejected; 4 = Completed
	registration_date DATE NOT NULL,
	required_date DATE NOT NULL,
	completion_date DATE,
	location_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (student_id) REFERENCES courses.students (student_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (location_id) REFERENCES courses.locations (location_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES courses.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE courses.registration_items (
	registration_id INT,
	item_id INT,
	course_id INT NOT NULL,
	quantity INT NOT NULL,
	class_hours DECIMAL (10, 2) NOT NULL,
	lab_hours DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (registration_id, item_id),
	FOREIGN KEY (registration_id) REFERENCES courses.registrations (registrations_id) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY (course_id) REFERENCES curriculum.subjects (course_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE curriculum.offerings (
	location_id INT,
	course_id INT,
	quantity INT,
	PRIMARY KEY (location_id, course_id),
	FOREIGN KEY (location_id) REFERENCES courses.locations (location_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (course_id) REFERENCES curriculum.subjects (course_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- define a select statement to get all students enrolled in a course
SELECT 
	courses.students.student_id,
	courses.students.first_name,
	courses.students.last_name,
	courses.students.email,
	courses.students.phone,
	courses.students.city,
	courses.students.state,
	courses.students.zip_code,
	courses.registrations.registration_id,
	courses.registrations.registration_status,
	courses.registrations.registration_date,
	courses.registrations.required_date,
	courses.registrations.completion_date,
	courses.registrations.location_id,
	courses.registrations.staff_id,
	courses.registration_items.item_id,
	courses.registration_items.course_id,
	courses.registration_items.quantity,
	courses.registration_items.class_hours,
	courses.registration_items.lab_hours
FROM courses.students
JOIN courses.registrations ON courses.students.student_id = courses.registrations.student_id
JOIN courses.registration_items ON courses.registrations.registration_id = courses.registration_items.registration_id
WHERE courses.registration_items.course_id = 1;
	
