\name{kzft}
\alias{kzft}
\alias{coeff.kzft}
\alias{transfun.kzft}
\title{Kolmogorov-Zurbenko Fourier transform}
\description{
  Kolmogorov-Zurbenko Fourier transform is an iterative moving average of the Fourier transform.
}
\details{
  Kolmogorov-Zurbenko Fourier transform (KZFT) was first introduced in Zurbenko (1986). It is an iterative moving average of the Fourier transform.  Regular Fourier transform has an energy leakage around the Fourier frequencies. KZFT may overcome the leakage by k degrees less where k is the number of iterations of the KZFT. Due to the property of KZ statistics, KZFT shows strong resistance to noise and can be applied to nonstationary processes and random fields. Zurbenko showed that KZFT has the closest to the optimal mean square error and very strong resistance to noise in the frequency domain. 
}
\usage{
kzft(x, m, k, p=1, n=1)
coeff.kzft(m,k)
transfun.kzft(m,k,lamda=seq(-0.5,0.5,by=0.01),omega=0)
}
\arguments{
  \item{x}{A vector of the time series}
  \item{m}{Length of the window size of the KZFT}
  \item{k}{Number of iterations of the KZFT}
  \item{p}{Percentage of overlap between two intervals}
  \item{n}{Multiple frequency rate of Fourier frequencies}
  \item{lamda}{A vector of frequencies}
  \item{omega}{A frequency of the transfer function}
}

\references{
  I. G. Zurbenko, 1986: The spectral Analysis of Time Series. North-Holland, 248 pp.

  I. G. Zurbenko, P. S. Porter, Construction of high-resolution wavelets, Signal Processing 65: 315-327, 1998.
}

\seealso{
  \code{\link{kzp}},
  \code{\link{kztp}},
  \code{\link{kzw}}.
}

\examples{

# example 1
# coefficient of the kzft

aa<-coeff.kzft(201,5);
tt<-seq(1:1001)-501;
zz<-cos(2*pi*0.025*tt);
plot(zz*aa,type="l",xlab="time units", ylab="envelope coefficient", 
    main="coefficient of the kzft");
lines(aa);
lines(-1*aa);

# example 2
# transfer function of the kzft

lamda<-seq(-0.1,0.1,by=0.001)
tf1<-transfun.kzft(201,1,lamda,0.025)
tf2<-transfun.kzft(201,5,lamda,0.025)
matplot(lamda,cbind(log(tf1),log(tf2)),type="l",ylim=c(-15,0),ylab="", 
        main="transfer function of the kzft")

#example 3

t<-1:1000
x<-cos(2*pi*(10/1000)*t)


kzft.x1<-kzft(x,200,1,0.005)
x1<-2*Re(kzft.x1$tf[,2])

kzft.x2<-kzft(x,200,2,0.005)
x2<-2*Re(kzft.x2$tf[,2])

kzft.x3<-kzft(x,200,3,0.005)
x3<-2*Re(kzft.x3$tf[,2])

par(mfrow=c(2,2))
plot(x,type="l",main="Original time series")
plot(x1,type="l",main="kzft(200,1)")
plot(x2,type="l",main="kzft(200,2)")
plot(x3,type="l",main="kzft(200,3)")

#example 4

t<-1:1000
x<-sin(2*pi*(10/1000)*t)


kzft.x1<-kzft(x,200,1,0.005)
x1<-2*Re(kzft.x1$tf[,2])

kzft.x2<-kzft(x,200,2,0.005)
x2<-2*Re(kzft.x2$tf[,2])

kzft.x3<-kzft(x,200,3,0.005)
x3<-2*Re(kzft.x3$tf[,2])

par(mfrow=c(2,2))
plot(x,type="l",main="Original time series")
plot(x1,type="l",main="kzft(200,1)")
plot(x2,type="l",main="kzft(200,2)")
plot(x3,type="l",main="kzft(200,3)")

}
\keyword{ts}


