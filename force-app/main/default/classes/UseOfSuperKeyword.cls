public virtual class UseOfSuperKeyword {
    public String name;
    public Integer age;

    public UseOfSuperKeyword (String name, Integer age) {
        this.name = name;
        this.age = age;
        System.debug('Person constructor: ' + name + ', ' + age);
    }
}












// Usage (e.g., in Execute Anonymous):
// Employee e = new Employee('Riya', 25, 'E-1001');