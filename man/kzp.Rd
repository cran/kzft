\name{kzp}
\alias{kzp}
\alias{nonlinearity.kzp}
\alias{variation.kzp}
\alias{smooth.kzp}

\title{Kolmogorov-Zurbenko Periodogram and Smoothing Methods}

\description{
  Kolmogorov-Zurbenko periodogram and smoothing using either DiRienzo-Zurbenko (DZ) or Neagu-Zurbenko (NZ) smoothing methods.
}

\details{
  Kolmogorov-Zurbenko periodogram is calculated based on the Kolmogorov-Zurbenko Fourier transform.
  Both DZ and NZ smoothing methods are adaptive which allow the bandwidth of the spectral window vary according to the smoothness of the underlying spectral density. In DZ algorithm, the squared variation of the periodogram is used to evaulate the smoothness of the spectrum.  When smoothing the periodogram, the bandwith of the spectral window is extended until the squared variation within the window reaches a prespecified percentage of total variation of the periodogram. In NZ algorithm, the only difference is to use a measure of nonlinearity to evaluate the smoothness of the spectrum.  In the situation when the variation is very small at certain frequencies, the bandwidth of the spectral window could be extended very large in order to achieve the prespecified percentage of the total variation.  However, this little improvement of the smoothness of the spectrum will cause a considerably increased amount of computation labor.  In the algorithms, we set a limit of the maximum bandwidth being allowed to avoid this situation.  For details, please refer to DiRienzo and Zurbenko (1998) and Neagu and Zurbenko (2003).  
}

\usage{
kzp(x, m, k, p=1, n=1)
nonlinearity.kzp(pg, K=length(pg))
variation.kzp(pg, K=length(pg))
smooth.kzp(pg,c,K=length(pg),method = "DZ")
}

\arguments{
  \item{x}{The raw time series}
  \item{m}{The length of the window size for a regular Fourier transform}
  \item{k}{The number of iterations for the KZFT}
  \item{p}{The distance between two successive intervals as a percentage of the total length of the time series}
  \item{n}{The sampling frequency rate as a multiplication of the Fourier frequencies}
  \item{pg}{The raw periodogram of a time series}
  \item{K}{Half length of the maximum bandwidth of the spectral window being allowed in the algorithms}
  \item{c}{A prespecified percentage of total nonlinearity/variation}
  \item{method}{Smooth methods: DZ or NZ}
}

\references{
  I. G. Zurbenko, 1986: The spectral Analysis of Time Series. North-Holland, 248 pp.

  I. G. Zurbenko, P. S. Porter, Construction of high-resolution wavelets, Signal Processing 65: 315-327, 1998.

  A. G. DiRienzo, I. G. Zurbenko, Semi-adaptive nonparametric spectral estimation, Journal of Computational and Graphical Statistics 8(1): 41-59, 1998.

  R. Neagu, I. G. Zurbenko, Algorithm for adaptively smoothing the log-periodgram, Journal of the Franklin Institute 340: 103-123, 2003.
  
}

\seealso{
  \code{\link{kzft}},
  \code{\link{kztp}},
  \code{\link{kzw}}.
}

\examples{

#example 1
#show the effect of smoothing methods

N<-480
x<-rep(0,N)

x[1:4]<-rnorm(4)

for ( t in 5:N ) 
{ 
x[t]<-2.76*x[t-1]-3.81*x[t-2]+2.65*x[t-3]-0.92*x[t-4]+rnorm(1)
}

for ( t in 1:N ) 
{
x[t]<-50*cos( 2*pi*(10/N)*t)+40*cos( 2*pi*(20/N)*t )+x[t]
}

kzp.x<-log(kzp(x,480,1))
spg.x1<-smooth.kzp(kzp.x,0.03, method="DZ")$periodogram
spg.x2<-smooth.kzp(kzp.x,0.03, method="NZ")$periodogram

omega<-seq(0,1,length=481)[2:241]

par(mfrow=c(2,2))
plot(omega,kzp.x,main="Raw periodogram",type="l", xlab="Frequency (cycles/time unit)", ylab=" ")
plot(omega,spg.x1,main="Smoothed Periodogram using DZ method",type="l", xlab="Frequency (cycles/time unit)", ylab=" ")
plot(omega,spg.x2,main="Smoothed Periodogram using NZ method",type="l", xlab="Frequency (cycles/time unit)", ylab=" ")

#example 2
#show the effect of KZFT
t<-1:2000
y<-1.1*sin(2*pi*0.0339*t)+7*sin(2*pi*0.0366*t)+2*rnorm(1000,0,1)
kzp.y1<-log(kzp(y,1000,1,0.1,1))
kzp.y2<-log(kzp(y,500,2,0.1,2))

spg.y1<-smooth.kzp(kzp.y1,0.01, method="NZ")$periodogram
spg.y2<-smooth.kzp(kzp.y2,0.01, method="NZ")$periodogram

omega<-seq(0,1,length=1001)[21:61]
par(mfrow=c(2,2))
plot(omega,kzp.y1[20:60], main="Periodogram m=1000, k=1", type="l", xlab="Frequency (cycles/time unit)", ylab=" ")
plot(omega,kzp.y2[20:60], main="Periodogram m=500, k=2", type="l", xlab="Frequency (cycles/time unit)", ylab=" ")
plot(omega,spg.y1[20:60], main="Smoothed Periodogram m=1000, k=1", type="l", xlab="Frequency (cycles/time unit)", ylab=" ")
plot(omega,spg.y2[20:60], main="Smoothed Periodogram m=500, k=2", type="l", xlab="Frequency (cycles/time unit)", ylab=" ")

}
\keyword{ts}



