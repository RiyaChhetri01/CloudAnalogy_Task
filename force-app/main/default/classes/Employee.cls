public class Employee extends UseOfSuperKeyword  {
    public String employeeId;

    public Employee(String name, Integer age, String employeeId) {
        super(name, age); 
        this.employeeId = employeeId;
        System.debug('Employee constructor: ' + employeeId);
    }
}