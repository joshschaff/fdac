# fdac
Frequency Domain Audio Codec

# What is FDAC?
FDAC is an audio codec and compression algorithm that achieves theoretical compression of over 50% while maintaining near-lossless fidelity. It aims to compete with outgoing lossless standards such as FLAC, the Free Lossless Audio Codec, and serve as a proof of concept for the emplyoing the same methodology of processor intensive realtime decoding, as utilized by video standards such as H.265, for decoding of compressed audio.

# FDAC vs. bitwise encodings
Traditional audio standards utilize a bitwise encoding that stores the relative amplitude of a summated audio signal acquired at a given frequency over time. The nature of this encoding means the audio data is stored in the time domain. Compression is achieved by simplifying the waveform being sampled, or reducing the precision of the sampling method. FDAC achieves its compression by utilizing the unique nature of audio data instead stored in the frequency domain.

# The Frequency Domain
The frequency domain maps a set of frequencies to their relative contribution towards a summated audio signal. The advantages of utilizing this type of encoding over the traditional bitwise method are numerous:
* Most audio tranformations are already performed in the frequency domain
  * Encoding of the frequency domain makes these operations easier
* Sound data of the summated wave is held by the interaction of multiple values rather than a single sample point
  * A lower level of precision is required for each individual frequency when compared to bitwise bitdepth
  * Much of the frequency domain can be reconstructed from mirrored components
  
  
