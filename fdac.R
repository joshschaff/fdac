library(tuneR)
library(abind)

# Store WAV file at 48khz
sndObj <- readWave('physics audio/beatles.wav')

# Read in raw bitwise sound data from left channel
# from 4.0 seconds to 4.1 seconds
sRaw <- sndObj@left[2928001:2928480]

# Convert to raw frequency data w/ fast fourier 
# Divide by the number of data points as transform
# returns higher sums for larger frequencies
fRaw <- fft(sRaw) /480

# New variable for data compress with criteria
# only the first half is unique
fComp <- fRaw[1:240]

# Compress the data (overrite non signifigant frequencies as zero)
fComp[abs(Mod(fComp)^2) < ave(abs(Mod(fComp)^2))/20] <- 0
#fComp[abs(Re(fComp)) < ave(abs(Re(fComp)))/3] <- 0
#fComp[abs(Im(fComp)) < ave(abs(Im(fComp)))/3] <- 0

# Multiplied by 2 for real and imaginary components
compressionRation <- (2 * sum(fComp !=0)) /240

# Rebuild the mirrored half of the FFT
# Appended with 0+0i to account for offset of 1
fCompSecondHalf <- Conj(c(0+0i, rev(fComp[2:240])))


# Reverse fourier w/ compressed frequencies
# to get compressed sound wave
sComp <- fft(c(fComp,fCompSecondHalf), inverse=TRUE)


freqArray <- (0:(239)) * (sndObj@samp.rate / 480)




#PLOT SOUND
plot((1:480), sRaw[1:480], type='l', lwd = 3)
lines((1:480), sComp[1:480], type='l', col='green', lwd = 3)
#PLOT FREQUNECY COMPONENTS
plot((freqArray), Re(fRaw)[1:240], type = 'l', col='black', lwd =1)
lines((freqArray), Im(fRaw)[1:240], type = 'l', col='red', lwd =1)
#PLOT FREQUENCY COMPRESSED AND NOT
plot((1:480), Re(fRaw), type = 'l', col='black', lwd =3)
lines((1:480), Im(fRaw), type = 'l', col='red', lwd =3)



#PRSENTATIONS

#Real and Imaginary
plot((freqArray), Re(fRaw)[1:480], type = 'l', col='black', lwd =1, xlab='Frequency (Hz)', ylab='Strength')
lines((freqArray), Im(fRaw)[1:480], type = 'l', col='green', lwd =1)


#Compressed and Not Frequencies (REAL)
plot((freqArray), Re(fRaw)[1:240], type = 'l', col='black', lwd =1, xlab='Frequency (Hz)', ylab='Strength')
lines((freqArray), Re(fComp)[1:240], type = 'l', col='red', lwd =1)


plot((1:480), Re(sRaw), type = 'l', col='black', lwd =1, xlab='Time (ms)', ylab='Pressure Difference')
lines((1:480), Re(sComp), type = 'l', col='red', lwd =1)
