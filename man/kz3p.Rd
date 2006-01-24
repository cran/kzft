\name{kz3p}
\alias{kz3p}
\alias{variation.kz3p}
\alias{smooth.kz3p}

\title{Kolmogorov-Zurbenko third-order periodogram and smoothing method}

\description{
  Kolmogorov-Zurbenko third-order periodogram and smoothing method
}

\details{
  Kolmogorov-Zurbenko third-order periodogram is calculated based on the Kolmogorov-Zurbenko Fourier transform.
  The smoothing method is adaptive which allows the bandwidth of the spectral window in the smoothed third-order periodogram running average procedure to vary according to the smoothness of the underlying spectral density. The bandwith is extended until the squared variation of the third-order periodogram within reaches a prespecified level of total variation.
}

\usage{
kz3p(x,m,k,p=1,n=1,rp1=0,rp2=0.5,cp1=0,cp2=0.5)
variation.kz3p(pg, K=dim(pg)[1])
smooth.kz3p(pg,c,K=dim(pg)[1])
}

\arguments{
  \item{x}{A vector of the time series}
  \item{m}{Length of the window size of the KZFT}
  \item{k}{Number of iterations of the KZFT}
  \item{p}{Percentage of overlap between two intervals}
  \item{n}{Multiple frequency rate of Fourier frequencies}
  \item{rp1}{Left bound for one dimension of third-order periodogram}
  \item{rp2}{Right bound for one dimension of third-order periodogram}
  \item{cp1}{Left bound for the other dimension of third-order periodogram}
  \item{cp2}{Right bound for the other dimension of third-order periodogram}   
  \item{pg}{The third-order periodogram of the time series}
  \item{K}{Half of the maximum bandwidth of the spectral window}
  \item{c}{A prespecified percentage of total variation}
}

\references{
  I. G. Zurbenko, 1986: The spectral Analysis of Time Series. North-Holland, 248 pp.

  I. G. Zurbenko, P. S. Porter, Construction of high-resolution wavelets, Signal Processing 65: 315-327, 1998.

  A. G. DiRienzo, I. G. Zurbenko, Semi-adaptive nonparametric spectral estimation, Journal of Computational and Graphical Statistics 8(1): 41-59, 1998.

  R. Neagu, I. G. Zurbenko, Algorithm for adaptively smoothing the log-periodgram, Journal of the Franklin Institute 340: 103-123, 2003.
  
}

\seealso{
  \code{\link{kzft}},
  \code{\link{kzp}}.
}

\examples{

#example 1

t<-1:10000
y<-sin(2*pi*0.1*t)+sin(2*pi*0.2*t)+rnorm(10000,0,3)

pg3.y<-kz3p(y,100,1,0.5,1)$mod
pg3.y<-log(pg3.y)
spg3.y<-smooth.kz3p(pg3.y,0.01,20)$bispectrum

omega<-seq(0,1,length=101)[2:51]

par(mfrow=c(2,1))
persp(omega, omega, pg3.y, theta = 30, phi = 30, expand = 0.5, col = "lightblue", ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency", ylab = "Frequency", main = "3rd-order Periodogram") 
persp(omega, omega, spg3.y, theta = 30, phi = 30, expand = 0.5, col = "lightblue", ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency", ylab = "Frequency", main = "Smoothed 3rd-order Periodogram")

filled.contour(omega,omega,pg3.y,xlab="Frequency",ylab="Frequency",main="3rd-order Periodogram")
filled.contour(omega,omega,spg3.y,xlab="Frequency",ylab="Frequency",main="Smoothed 3rd-order Periodogram3")

#example 3
#effect of KZFT

t<-1:50000
y<-1.1*sin(2*pi*0.0339*t)+7*sin(2*pi*0.0366*t)+2*rnorm(50000,0,1)

pg3.y1<-kz3p(y,1000,1,0.5,1,rp1=0.02,rp2=0.05,cp1=0.02,cp2=0.05)$mod
pg3.y2<-kz3p(y,1000,3,0.5,1,rp1=0.02,rp2=0.05,cp1=0.02,cp2=0.05)$mod
pg3.y1<-log(pg3.y1)
pg3.y2<-log(pg3.y2)
spg3.y1<-smooth.kz3p(pg3.y1,0.01,10)$bispectrum
spg3.y2<-smooth.kz3p(pg3.y2,0.01,10)$bispectrum

omega<-seq(0,1,length=1001)[21:51]
par(mfrow=c(2,2))
persp(omega, omega, pg3.y1, theta = 30, phi = 30, expand = 0.5, col = "lightblue", ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency", ylab = "Frequency", main = "Original, m=1000, k=1") 
persp(omega, omega, pg3.y2, theta = 30, phi = 30, expand = 0.5, col = "lightblue", ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency", ylab = "Frequency", main = "Original, m=1000, k=3")
persp(omega, omega, spg3.y1, theta = 30, phi = 30, expand = 0.5, col = "lightblue", ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency", ylab = "Frequency", main = "Smoothed, m=1000, k=1") 
persp(omega, omega, spg3.y2, theta = 30, phi = 30, expand = 0.5, col = "lightblue", ltheta = 120, shade = 0.75, ticktype = "detailed", xlab = "Frequency", ylab = "Frequency", main = "Smoothed, m=1000, k=3")

filled.contour(omega,omega,pg3.y1,xlab="Frequency",ylab="Frequency",main="Original, m=1000, k=1")
filled.contour(omega,omega,pg3.y2,xlab="Frequency",ylab="Frequency",main="Original, m=1000, k=3")
filled.contour(omega,omega,spg3.y1,xlab="Frequency",ylab="Frequency",main="Smoothed, m=1000, k=1")
filled.contour(omega,omega,spg3.y2,xlab="Frequency",ylab="Frequency",main="Smoothed, m=1000, k=3")
}
\keyword{ts}


