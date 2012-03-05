import std.stdio;
import std.socket;

void main() {
  ushort port = 19863;
  
  Socket connection = new UdpSocket();

  writefln("Local Host: %s", Socket.hostName());
  write("Address: ");
  string address = readln();
  InternetAddress inet = new InternetAddress(address, port);
  writeln(inet);

  byte[2] header = [cast(byte)0xFF, cast(byte)0xFF];

  writeln("binding");
  connection.bind(new InternetAddress(InternetAddress.PORT_ANY));

  connection.sendTo(header ~ [cast(byte)'p'], new InternetAddress(address, port));
  byte[100] buffer;
  Address ASender;
  InternetAddress IASender;
  bool recieved = false;
  while (recieved == false) {
    long result = connection.receiveFrom(buffer, ASender);
    if (result == 0 || result == Socket.ERROR) continue;
    IASender = cast(InternetAddress)ASender;
    if (IASender.port != inet.port || IASender.addr != inet.addr) continue;
    writeln(buffer);
    if (buffer[0..3] == [cast(byte)0xFF, cast(byte)0xFF, 'p']) recieved = true;
  }
}