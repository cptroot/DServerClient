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

  byte[2] header = [0xFF, 0xFF];

  Address[] clients;
  bool running = true;
  while(running) {
    Address address;
    long result = listener.receiveFrom(buffer, address);
    if (result != 0 && result != Socket.ERROR) {
      if (buffer[0..2] != header) continue;
      byte[] data;
      if (canFind(clients, address)) {
        
      } else {
        switch (buffer[2]) {
          case 'p':
            listener.sendTo(header ~ data, address);
            break;
        }
      }
    }
  }
}