mixin Animal {
void voice(){}
void size(int a){
print("Size is "+a.toString()+" cm");
}

}
class Dog with Animal{
    @override
    void voice() {
        print("Woof!");
    }
}
void main(List<String> args) {
  Dog d = Dog();
  d.voice(); // Woof!
  d.size(100); // Size is 100 cm
}