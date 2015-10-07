NetAddr.langPort;
(
f = { |msg, time, addr|
    if(msg[0] == '/telegram-text') {
		msg[1].postln;
		("say -v 'Vicki' \"" + msg[1] + "\"").unixCmd;
    };

    if(msg[0] == '/telegram-notes') {
		for (1, msg.size - 1, { arg i; msg[i].postln });
	};
};
)

thisProcess.removeOSCRecvFunc(f);
thisProcess.addOSCRecvFunc(f);






