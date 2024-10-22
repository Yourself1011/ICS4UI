class Section {
    String code, teacher;
    ArrayList<Student> students;

    Section (String code, String teacher) {
        this.code = code;
        this.teacher = teacher;
        this.students = new ArrayList<Student>();
    }

    void addStudent(Student student) {
        this.students.add(student);
        Collections.sort(this.students, (Student s1, Student s2) -> s1.name.split(" ", 2)[1].compareTo(s2.name.split(" ", 2)[1]));
    }

    @Override
    String toString() {
        String studentNames = "";
        for (int i = 0; i < students.size(); i++) {
            studentNames += (i + 1) + ". " + students.get(i).name + "\n";
        }
        return code + "\t" + teacher + "\n" + studentNames;
    }
}
