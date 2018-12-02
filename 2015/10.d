import std.stdio;
import std.conv;

string rehash(string str) {
	int i = 0;
	int total = 0;
	char digit;
	string rehashed = "";
	for (i=0; i<str.length; i++) {
		if (digit != str[i]) {
			if (i > 0) {
				rehashed = rehashed ~ to!string(total) ~ digit;
			}
			digit = str[i];
			total = 1;
		} else {
			total = total + 1;
		}
	}
	rehashed = rehashed ~ to!string(total) ~ digit;
	return rehashed;
}

int main(string[] args) {
	int i = 0;
	string str = "1321131112";
	for (i=0; i<50; i++) {
		writeln(i);
		str = rehash(str);
	}
	writeln(str);
	return 0;
}