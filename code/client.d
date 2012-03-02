import std.stdio;
import std.socket;

void main() {
  ushort port = 19863;
  
  Socket connection = new UdpSocket();
  connection.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, true);

  writefln("Local Host: %s", Socket.hostName());
  write("Address: ");
  string address = readln();
  InternetAddress inet = new InternetAddress(address, port);

  byte[2] header = [cast(byte)0xFF, cast(byte)0xFF];

  connection.sendTo(header ~ [cast(byte)'p'], new InternetAddress(address, port));
  writeln("binding");
  connection.bind(new InternetAddress(port));
  byte[100] buffer;
  Address sender;
  bool recieved = false;
  while (recieved == false) {
    connection.receiveFrom(buffer, sender);
    if (sender != inet) continue;
    if (buffer == [cast(byte)0xFF, cast(byte)0xFF, 'p']) recieved = true;
  }
}