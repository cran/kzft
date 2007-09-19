\name{kzw}
\alias{kzw}
\alias{kzww}
\title{Kolmogorov-Zurbenko Wavelet}
\description{
  Kolmogorov-Zurbenko Wavelet is calculated based on Kolmogorov-Zurbenko Fourier transform.
}
\details{
  Kolmogorov-Zurbenko Wavelet (KZW) is used to calculte the time-frequency estimation of a time series.  It is calculated based on Kolmogorov-Zurbenko Fourier transform.  Because of this, it is strongly robust with respect to noise and has a very high resolution property. There are two versions of KZW algorithm, kzw and kzww. The only difference between the two algorithms is the definition of the window size. In kzw, the window size is a multiplication of the period at which the spectrum is calculated. In another word, different length of window is used to calculate the spectrum at different frequencies.  In kzww, the window size is fixed for all interested.
}
\usage{
kzw(x,f1=1/length(x),f2=0.5,delta.f=1/length(x),t1=1,t2=length(x),
delta.t=1,n,k=3,method="zero")
kzww(x,f1=1/length(x),f2=0.5,delta.f=1/length(x),t1=1,t2=length(x),
delta.t=1,m,k=3,method="zero")
}
\arguments{
  \item{x}{The raw time series}
  \item{f1}{The left bound of frequencies at which time-frequency estimation is calculated}
  \item{f2}{The right bound of frequencies at which time-freqeuncy estimation is calculated}
  \item{delta.f}{Interval of the sampling frequency}
  \item{t1}{The left bound of time}
  \item{t2}{The right bound of time}
  \item{delta.t}{Interval of time}
  \item{n}{The sampling frequency rate as a multiplication of the Fourier frequencies}
  \item{m}{The length of the window size for a regular Fourier transform}
  \item{k}{The number of iterations for the KZFT}
  \item{method}{The methods of how to extend time series at either end.  The options can be either "zero" (adding zeroes) or "repeat" (symmetrically repeat the time series)}
}

\references{
  I. G. Zurbenko, 1986: The spectral Analysis of Time Series. North-Holland, 248 pp.

  I. G. Zurbenko, P. S. Porter, Construction of high-resolution wavelets, Signal Processing 65: 315-327, 1998.

  R. Neagu, I. G. Zurbenko, Tracking and separating non-stationary multi-component chirp signals, Journal of Franklin Institute 339: 499-520, 2002.
}

\seealso{
  \code{\link{kzft}},
  \code{\link{kzp}},
  \code{\link{kztp}}.
}

\examples{
# example
t=1:999
p1=rep(10,333)
p2=rep(20,333)
p=c(p1,p2,p1)
f=1/p

x=sin(2*pi*f*t)+rnorm(999,0,1)
plot(t,x,type='l',xlab="Time unit")

kzw.x=kzw(x,30/999,120/999,1/999,1,999,1,7,5)
ff=30:120/999
contour(t,ff,kzw.x$em, xlab="Time unit", ylab="Frequency (cycles/time unit)")
lines(t,f,col="red")
}

\keyword{ts}




