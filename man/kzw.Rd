\name{kzw}
\alias{kzw}
\alias{kzww}
\title{Kolmogorov-Zurbenko Wavelet}
\description{
  Kolmogorov-Zurbenko Wavelet is calculated based on Kolmogorov-Zurbenko Fourier transform.
}
\details{
  Kolmogorov-Zurbenko Wavelet is calculated based on Kolmogorov-Zurbenko Fourier transform. KZW maybe considered as a nonparametric version of wavelet transform. It does not need to have parametric base functions. Since it is based on the Kolmogorov-Zurbenko Fourier transform, it is strongly robust with respect to noise and information in different frequencies. It also has a very high resolution property. There are two versions of KZW in this package. There is no difference between these two functions except the definition of the window size. In kzw, the window size is a multiplication of the period which is one over the frequency of interest. In kzww, the window size is fixed for all interested frequencies.
}
\usage{
kzw(x,f1=1/length(x),f2=0.5,delta.f=1/length(x),t1=1,t2=length(x),
delta.t=1,n,k=3,method="zero")
kzww(x,f1=1/length(x),f2=0.5,delta.f=1/length(x),t1=1,t2=length(x),
delta.t=1,m,k=3,method="zero")
}
\arguments{
  \item{x}{A vector of the time series}
  \item{f1}{left bound of sampling frequency}
  \item{f2}{right bound of sampling frequency}
  \item{delta.f}{samplling frequency interval}
  \item{t1}{left bound of time}
  \item{t2}{right bound of time}
  \item{delta.t}{time interval}
  \item{n}{Multiple of the period}
  \item{m}{Length of the window size}
  \item{k}{Number of iterations of the KZFT}
  \item{method}{Methods of extending time series at both ends.It is either zero (adding zeroes) or repeat (symmetrically repeat the time series)}
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
plot(t,x,type='l')

kzw.x=kzw(x,30/999,120/999,1/999,1,999,1,7,5)
ff=30:120/999
contour(t,ff,kzw.x$em)
lines(t,f,col="red")
}

\keyword{ts}




