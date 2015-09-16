b = NetAddr.new("127.0.0.1", 7771);    // create the NetAddr
b.sendMsg("/hello", "there");




(
f = { |msg, time, addr|
    if(msg[0] == '/telegram') {
		msg[1].postln;
		("say -v 'Vicki' '" + msg[1] + "'").unixCmd;
    }
};
thisProcess.addOSCRecvFunc(f);
)

NetAddr.langPort;

// stop posting.
thisProcess.removeOSCRecvFunc(f);