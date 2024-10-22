class Student {
    String name, email;
    int studentNumber, grade, age;
    Section[] sections;

    Student (String name, int studentNumber, int grade, int age, Section[] sections) {
        this.name = name;
        this.studentNumber = studentNumber;
        String studentNumberString = Integer.toString(studentNumber);
        this.grade = grade;
        this.age = age;
        String lastName = name.split(" ", 2)[1].replaceAll(" ", "");
        this.email = (lastName
            .substring(0, min(4, lastName.length()))
             + name.substring(0, 1)
             + studentNumberString
            .substring(studentNumberString.length() - 4)
            ).toLowerCase() + "@wrdsb.ca";

        this.sections = sections;
        for (Section section : sections) {
            if (section != null) {
                section.addStudent(this);
            }
        }
    }

    // void addSection(Section section, int period) {
    //     this.sections[period] = section;
    //     section.addStudent(this);
    // }

    @Override
    String toString() {
        String sectionOutput = "";
        for (int i = 0; i < sections.length; ++i) {
            sectionOutput += "Period " + (i + 1) + "\t" + (sections[i] == null ? "Spare" : sections[i].code) + "\n";
        }
        return name + "\t" + studentNumber + "\tGrade " + grade + "\t" + email + "\n" + sectionOutput;
    }
}