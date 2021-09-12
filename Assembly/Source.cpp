#include <iostream>

class MyClass;
extern "C" int some_function();
extern "C" int structures(MyClass& m);
extern "C" int looper();
extern "C" int arrays();


/////////for structues.asm//////////////
//#pragma pack(1) no padding!
struct MyStruct
{
	char c; //byte 0
	int i;	//byte 4
	short s; //byte 8
	double d; //byte 16
	//total 24 bytes
};

class MyClass
{
private:
	int i;
public :
	int get_i() { return i; }
};
/////////////////////////////////

int main()
{
	for (int i = 0; i < 0; i++)
	{
		std::cout << " buye" << std::endl;
	}
	some_function();
	//looper();
	arrays();
	//MyClass c;
	//structures(c);
	//std::cout << c.get_i() << std::endl;
}