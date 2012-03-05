import std.stdio;
import std.socket;
import std.datetime;
import std.algorithm;

void main() {
  ushort port = 19863;
  Socket listener = new UdpSocket();
  listener.blocking = true;

  listener.setOption(SocketOptionLevel.SOCKET, SocketOption.RCVTIMEO, dur!"seconds"(1));

  listener.bind(new InternetAddress(port));

  byte[100] buffer;

  byte[2] header = [cast(byte)0xFF, cast(byte)0xFF];
  writeln(header);

  Address[] clients;
  bool running = true;
  while(running) {
    Address address;
    long result = listener.receiveFrom(buffer, address);
    if (result != 0 && result != Socket.ERROR) {
      if (buffer[0..2] != header) continue;
      byte[] data;
      writeln("received data");
      writeln(buffer);
      if (canFind(clients, address)) {
        
      } else {
        switch (buffer[2]) {
          case 0x01:
            data = [0x01];
            listener.sendTo(header ~ data, address);
            break;
          default:
            break;
        }
      }
    }
  }
}