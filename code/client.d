import std.stdio;
import std.socket;

void main() {
  ushort port = 19863;
  
  Socket connection = new UdpSocket();

  writefln("Local Host: %s", Socket.hostName());
  write("Address: ");
  string address = readln();
  InternetAddress inet = new InternetAddress(address, port);

  connection.sendTo([0xFF, 0xFF, 'p'], new InternetAddress(address, port));
  byte[100] buffer;
  Address sender;
  bool recieved = false;
  while (recieved == false) {
    connection.receiveFrom(buffer, sender);
    if (sender != inet) continue;
    if (buffer == [0xFF, 0xFF, 'p']) recieved = true;
  }
}