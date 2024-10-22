import java.util.Arrays;
import java.util.Collections;

void setup() {

    // Course nbe3ui = new Course("NBE3UI");
    
    // nbe3ui.addSections(new Section[]{
        
    // })
    
    Section nbe3ui11 = new Section("NBE3UI-11", "Georgia Gingrich");
    Section sch3ui07 = new Section("SCH3UI-07", "Sarah Beaton");
    Section ics4ui02 = new Section("ICS4UI-02", "Jason Schattman");
    Section sph3ui02 = new Section("SPH3UI-02", "Jonathan Nelson");
    Section sph3ui01 = new Section("SPH3UI-01", "Jonathan Nelson");
    Section mcr3uw01 = new Section("MCR3UW-01", "Angela Zorzitto");
    Section mcr3uw02 = new Section("MCR3UW-02", "Angela Zorzitto");
    Section tej3mi02 = new Section("TEJ3MI-02", "Robert Webb");

    Student[] students = {
        new Student("Allan Joe George", 340522178, 11, 16, new Section[] {nbe3ui11, ics4ui02, mcr3uw02, sph3ui01}),
        new Student("Matthew Yu", 240521072, 11, 16, new Section[] {sch3ui07, ics4ui02, sph3ui02, tej3mi02}),
        new Student("LiFeng Yin", 123458409, 11, 15, new Section[] {nbe3ui11, null, sph3ui02, mcr3uw01}),
        new Student("Daniel Zhang", 340525443, 11, 16, new Section[] {sch3ui07, ics4ui02, sph3ui02, mcr3uw01}),
    };
    
    println(ics4ui02);
    printArray(students);
    exit();
}