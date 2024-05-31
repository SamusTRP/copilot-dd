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


-- write an index to improve the performance of the query
CREATE INDEX idx_student_name ON courses.students (last_name, first_name);
CREATE INDEX idx_location_name ON courses.locations (location_name);
CREATE INDEX idx_staff_name ON courses.staffs (last_name, first_name);
CREATE INDEX idx_registration_status ON courses.registrations (registration_status);
CREATE INDEX idx_registration_date ON courses.registrations (registration_date);
CREATE INDEX idx_required_date ON courses.registrations (required_date);
CREATE INDEX idx_completion_date ON courses.registrations (completion_date);
CREATE INDEX idx_registration_items ON courses.registration_items (course_id);
CREATE INDEX idx_offerings ON curriculum.offerings (location_id, course_id);


-- define a table for student attendance to capture attendance by class
CREATE TABLE courses.attendance (
    attendance_id INT IDENTITY (1, 1) PRIMARY KEY,
    registration_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    attendance_status tinyint NOT NULL,
    -- Attendance status: 1 = Absent; 2 = Present; 3 = Excused
    FOREIGN KEY (registration_id) REFERENCES courses.registrations (registration_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- define a stored procedure to get course enrollment by location
CREATE PROCEDURE GetCourseEnrollmentByLocation
    @location_id INT
AS
BEGIN
    SELECT c.course_id, c.product_name, COUNT(r.registration_id) AS enrollment
    FROM curriculum.subjects AS c
    INNER JOIN courses.registration_items AS ri ON c.course_id = ri.course_id
    INNER JOIN courses.registrations AS r ON ri.registration_id = r.registration_id
    WHERE r.location_id = @location_id
    GROUP BY c.course_id, c.product_name;
END;

CREATE PROCEDURE GetInstructorDetailsByLocation
    @instructor_id INT
AS
BEGIN
    SELECT i.instructor_id, i.instructor_name, l.location_id, l.location_name, c.course_id, c.course_name
    FROM instructors AS i
    INNER JOIN locations AS l ON i.location_id = l.location_id
    INNER JOIN courses AS c ON i.instructor_id = c.instructor_id
    WHERE i.instructor_id = @instructor_id;
END;

SELECT * 
FROM courses.registrations 
WHERE registration_date >= '2023-09-01' AND registration_date < '2023-10-01';
