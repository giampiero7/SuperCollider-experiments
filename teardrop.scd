s.boot;
s.scope;

// Defs ===================

(
var beat;

c = Bus("audio", 3, 1, s); // direction bus
e = Bus("audio", 4, 1, s); // effect bus

beat = { | noise, sustain |
	noise * EnvGen.kr(Env.perc(0, sustain), doneAction: 2);
};

SynthDef(\drumPink, { | sustain |
    Out.ar(c, beat.value(PinkNoise.ar, sustain));
}).add;

SynthDef(\drumWhite, { | sustain |
    Out.ar(c, beat.value(WhiteNoise.ar, sustain));
}).add;

SynthDef(\sin, { | freq |
	Out.ar(c, SinOsc.ar(freq, 0, 0.3, 0));
}).add;

SynthDef(\bass, { | freq |
	Out.ar(c, (SinOsc.ar(freq) * EnvGen.kr(Env.perc(0, 2.2), doneAction: 2)));
}).add;

SynthDef(\dir, { | direct = 1 |
    var input;
    input = In.ar(c, 1);
	Out.ar(0, (input * direct) ! 2);
    Out.ar(e, input * (1 - direct));
}).add;

SynthDef(\reverb, {
    var input;
    input = In.ar(e, 1);
	10.do({ input = AllpassC.ar(input, 0.04, { Rand(0.001,0.04) }.dup, 3)});
    Out.ar(0, input);
}).add;

)

// Instantiate ===================

(
r = Synth(\reverb);
o = Synth.before(r, \dir);

d = Routine({
	var c;
	c = 0;
    loop {
		[0.2, 0.4, 0.2, 0.8].do({ |wait|
			c = (c + 1) % 4;
			if (c == 0) {
				Synth.before(o, \drumWhite, [sustain: 0.3]);
			} {
				Synth.before(o, \drumPink, [sustain: 0.4]);
			};
			wait.yield;
		})
    }
});

m = Routine({
	x = Synth.before(o, \sin, [freq: 0]);
    loop {
		[
			0, 440.00, 659.25, 440.00, 587.33, 440.00, 587.33, 659.25,
			0, 440.00, 659.25, 440.00, 587.33, 440.00, 587.33, 440.00,
		].do({ |freq|
			x.set("freq", freq);
			0.4.yield;
		})
    }
});

b = Routine({
    loop {
		[220, 196, 174.61, 220].do({ | freq |
			Synth.before(o, \bass, [freq: freq]);
			3.2.yield;
		})
    }
});

)

// Play ===================

d.play;
m.play;

o.set("direct", 0);

b.play;

b.stop;
d.stop;
m.stop;



"say -v 'Vicki' 'Love, love is a verb'".unixCmd;
"say -v 'Vicki' 'Love is a doing word'".unixCmd;
"say -v 'Vicki' 'Fearless, on my breath'".unixCmd;

"say -v 'Kathy' 'Gentle impulsion'".unixCmd;
"say -v 'Kathy' 'Shakes me, makes me lighter'".unixCmd;
"say -v 'Kathy' 'Fearless, on my breath'".unixCmd;

"say -v 'Trinoids' 'Teardrop on the fire'".unixCmd;
"say -v 'Trinoids' 'Fearless, on my breath'".unixCmd;


