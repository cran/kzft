\name{kztp}
\alias{kztp}
\alias{variation.kztp}
\alias{smooth.kztp}

\title{Kolmogorov-Zurbenko Third-Order Periodogram and Smoothing Method}

\description{
  Kolmogorov-Zurbenko third-order periodogram and smoothing method
}

\details{
  Kolmogorov-Zurbenko third-order periodogram is calculated based on the Kolmogorov-Zurbenko Fourier transform.
  The smoothing algorithm is very similar to the DZ algorithm used in smoothing the periodogram.  It is also an adaptive algorithm which allows the bandwidth of the spectral window to vary according to the smoothness of the underlying bispectrum density. The spectral window being used here is a square window.  In the algorithm, the bandwith of the square window is extended until the squared variation of the third-order periodogram within the window reaches a prespecified percentage of the total variation of the raw third-order periodogram.
}

\usage{
kztp(x,m,k,p=1,n=1,rp1=0,rp2=0.5,cp1=0,cp2=0.5)
variation.kztp(pg, K=dim(pg)[1])
smooth.kztp(pg,c,K=dim(pg)[1])
}

\arguments{
  \item{x}{The raw time series}
  \item{m}{The length of the window size for a regular Fourier transform}
  \item{k}{The number of iterations for the KZFT}
  \item{p}{The distance between two successive intervals as a percentage of the total length of the time series}
  \item{n}{The sampling frequency rate as a multiplication of the Fourier frequencies}
  \item{rp1}{The left bound of the frequencies at which the third-order periodogram will be calculated in one frequency dimension}
  \item{rp2}{The right bound of the frequencies at which the third-order periodogram will be calculated in one frequency dimension}
  \item{cp1}{The left bound of the frequencies at which the third-order periodogram will be calculated in the other frequency dimension}
  \item{cp2}{The right bound of the frequencies at which the third-order periodogram will be calculated in the other frequency dimension}
  \item{pg}{The raw third-order periodogram of a time series}
  \item{K}{Half of the maximum bandwidth of the spectral window being allowed}
  \item{c}{A prespecified percentage of total variation}
}

\references{
  I. G. Zurbenko, 1986: The spectral Analysis of Time Series. North-Holland, 248 pp.

  I. G. Zurbenko, P. S. Porter, Construction of high-resolution wavelets, Signal Processing 65: 315-327, 1998.

  W. Yang, I. G. Zurbenko, A semi-adaptive smoothing algorithm in bispectrum estimation, Proceedings of the American Statistical Association, Seattle, 2006.
  
}

\seealso{
  \code{\link{kzft}},
  \code{\link{kzp}},
  \code{\link{kzw}}.
}

\examples{

#example 1

t<-1:10000
y<-sin(2*pi*0.1*t)+sin(2*pi*0.2*t)+rnorm(10000,0,3)

pg3.y<-kztp(y,100,1,0.5,1)$mod
pg3.y<-log(pg3.y)
spg3.y<-smooth.kztp(pg3.y,0.01,20)$bispectrum

omega<-seq(0,1,length=101)[2:51]

par(mfrow=c(2,1))
persp(omega, omega, pg3.y, theta = 30, phi = 30, expand = 0.5, col = "lightblue", 
      ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency (cycles/time unit)", 
      ylab = "Frequency (cycles/time unit)", main = "3rd-order Periodogram") 
persp(omega, omega, spg3.y, theta = 30, phi = 30, expand = 0.5, col = "lightblue",
      ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency (cycles/time unit)",
      ylab = "Frequency (cycles/time unit)", main = "Smoothed 3rd-order Periodogram")

filled.contour(omega,omega,pg3.y,xlab="Frequency (cycles/time unit)",ylab="Frequency (cycles/time unit)",
               main="3rd-order Periodogram")
filled.contour(omega,omega,spg3.y,xlab="Frequency (cycles/time unit)",ylab="Frequency (cycles/time unit)",
               main="Smoothed 3rd-order Periodogram3")

#example 2
#effect of KZFT

t<-1:50000
y<-1.1*sin(2*pi*0.0339*t)+7*sin(2*pi*0.0366*t)+2*rnorm(50000,0,1)

pg3.y1<-kztp(y,1000,1,0.5,1,rp1=0.02,rp2=0.05,cp1=0.02,cp2=0.05)$mod
pg3.y2<-kztp(y,1000,3,0.5,1,rp1=0.02,rp2=0.05,cp1=0.02,cp2=0.05)$mod
pg3.y1<-log(pg3.y1)
pg3.y2<-log(pg3.y2)
spg3.y1<-smooth.kztp(pg3.y1,0.01,10)$bispectrum
spg3.y2<-smooth.kztp(pg3.y2,0.01,10)$bispectrum

omega<-seq(0,1,length=1001)[21:51]
par(mfrow=c(2,2))
persp(omega, omega, pg3.y1, theta = 30, phi = 30, expand = 0.5, col = "lightblue",
      ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency (cycles/time unit)",
      ylab = "Frequency (cycles/time unit)", main = "Original, m=1000, k=1") 
persp(omega, omega, pg3.y2, theta = 30, phi = 30, expand = 0.5, col = "lightblue", 
      ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency (cycles/time unit)", 
      ylab = "Frequency (cycles/time unit)", main = "Original, m=1000, k=3")
persp(omega, omega, spg3.y1, theta = 30, phi = 30, expand = 0.5, col = "lightblue", 
      ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency (cycles/time unit)", 
      ylab = "Frequency (cycles/time unit)", main = "Smoothed, m=1000, k=1") 
persp(omega, omega, spg3.y2, theta = 30, phi = 30, expand = 0.5, col = "lightblue", 
      ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency (cycles/time unit)", 
      ylab = "Frequency (cycles/time unit)", main = "Smoothed, m=1000, k=3")

filled.contour(omega,omega,pg3.y1,xlab="Frequency (cycles/time unit)",ylab="Frequency (cycles/time unit)",
               main="Original, m=1000, k=1")
filled.contour(omega,omega,pg3.y2,xlab="Frequency (cycles/time unit)",ylab="Frequency (cycles/time unit)",
               main="Original, m=1000, k=3")
filled.contour(omega,omega,spg3.y1,xlab="Frequency (cycles/time unit)",ylab="Frequency (cycles/time unit)",
               main="Smoothed, m=1000, k=1")
filled.contour(omega,omega,spg3.y2,xlab="Frequency (cycles/time unit)",ylab="Frequency (cycles/time unit)",
               main="Smoothed, m=1000, k=3")
}
\keyword{ts}


