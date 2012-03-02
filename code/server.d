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
      writeln(buffer);
      if (buffer[0..2] != header) continue;
      byte[] data;
      writeln("received data");
      if (canFind(clients, address)) {
        
      } else {
        writeln(buffer[2]);
        switch (buffer[2]) {
          case 'p':
            data = ['p'];
            listener.sendTo(header ~ data, address);
            break;
          default:
            break;
        }
      }
    }
  }
}