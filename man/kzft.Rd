\name{kzft}
\alias{kzft}
\alias{coeff.kzft}
\alias{transfun.kzft}
\title{Kolmogorov-Zurbenko Fourier Transform}
\description{
  Kolmogorov-Zurbenko Fourier transform is an iterative moving average of the regular Fourier transform.
}
\details{
Kolmogorov-Zurbenko Fourier transform (KZFT) is a special case of Fourier transform which is used to calculate the periodogram.  It was first introduced in Zurbenko (1986). It is an iterative moving average of the regular Fourier transform. A KZFT with parameters m and k (KZFT(m,k)) is defined as k times iteration of a regular Fourier transform over the data with a length of m.  Regular Fourier transform has an energy leakage around the Fourier frequencies. KZFT may overcome the leakage by k degrees less where k is the number of iterations in the KZFT. Because of this, KZFT shows strong resistance to noises and can be used to generate high resolution spectrum. From the point view of mean square error, Zurbenko (1986) also showed that KZFT has the closest to the optimal mean square error.  For the detailed definition of KZFT, please refer to Zurbenko and Porter (1998) and Neagu and Zurbenko (2002).  For information of spectral analysis, please refer to Shumway and Stoffer (2006).

In this package, the frequency unit is cycles per unit time, where the time unit is the time interval of the discrete observations in the raw time series. For example, a signal with a frequency of 0.1 corresponds to a period of 10 time units.  If the raw time series is recorded as one obeservation per day, then the period for this signal is 10 days.

}
\usage{
kzft(x, m, k, p=1, n=1)
coeff.kzft(m,k)
transfun.kzft(m,k,lamda=seq(-0.5,0.5,by=0.01),omega=0)
}
\arguments{
  \item{x}{The raw time series}
  \item{m}{The length of the window size for a regular Fourier transform}
  \item{k}{The number of iterations for the KZFT}
  \item{p}{The distance between two successive intervals as a percentage of the total length of the time series}
  \item{n}{The sampling frequency rate as a multiplication of the Fourier frequencies}
  \item{lamda}{A sequence of frequencies at which the transfer function is calculated}
  \item{omega}{A kernal frequency at which the KZFT is applied}
}

\references{
  I. G. Zurbenko, The spectral Analysis of Time Series. North-Holland, 1986.

  I. G. Zurbenko, P. S. Porter, Construction of high-resolution wavelets, Signal Processing 65: 315-327, 1998.

  R. Neagu, I. G. Zurbenko, Tracking and separating non-stationary multi-component chirp signals, J. Franklin Inst., 499-520, 2002.

  R. H. Shumway, D. S. Stoffer, Time Series Analysis and Its Applications: With R Examples, Springer, 2006.
}

\seealso{
  \code{\link{kzp}},
  \code{\link{kztp}},
  \code{\link{kzw}}.
}

\examples{

# example 1
# coefficient of the kzft(201,5)

aa<-coeff.kzft(201,5);
tt<-seq(1:1001)-501;
zz<-cos(2*pi*0.025*tt);
plot(zz*aa,type="l",xlab="Time unit", ylab="The coefficient", 
    main="Coefficients of the kzft");
lines(aa);
lines(-1*aa);

# example 2
# transfer function of the kzft(201,5) at frequency 0.025

lamda<-seq(-0.1,0.1,by=0.001)
tf1<-transfun.kzft(201,1,lamda,0.025)
tf2<-transfun.kzft(201,5,lamda,0.025)
matplot(lamda,cbind(log(tf1),log(tf2)),type="l",ylim=c(-15,0),ylab="Natural log transformation of the coefficients", xlab="Frequency (cycles/time unit)",
        main="Transfer function of kzft(201,5) at frequency 0.025")

#example 3
#The example shows the KZFT reproduces nearly perfectly the noise-free pattern of a sin wave with a constant frequency

# raw time series with frequency of 0.01
t<-1:1000
x<-cos(2*pi*(10/1000)*t)

#kzft(200,1) calcualted every one time unit at freuquency 0.01
kzft.x1<-kzft(x,200,1,0.005)
x1<-2*Re(kzft.x1$tf[,2])

#kzft(200,2) calcualted every one time unit at freuquency 0.01
kzft.x2<-kzft(x,200,2,0.005/2)
x2<-2*Re(kzft.x2$tf[,2])

#kzft(200,3) calcualted every one time unit at freuquency 0.01
kzft.x3<-kzft(x,200,3,0.005/3)
x3<-2*Re(kzft.x3$tf[,2])

par(mfrow=c(2,2))
plot(x,type="l",main="Original time series",xlab="Time unit", ylab="Amplitude")
plot(x1,type="l",main="kzft(200,1)",xlab="Time unit", ylab="Amplitude")
plot(x2,type="l",main="kzft(200,2)",xlab="Time unit", ylab="Amplitude")
plot(x3,type="l",main="kzft(200,3)",xlab="Time unit", ylab="Amplitude")

#example 4
#The example shows the KZFT reproduces nearly perfectly the noise-free pattern of a cos wave with a constant frequency

# raw time series with frequency of 0.01
t<-1:1000
x<-sin(2*pi*(10/1000)*t)

#kzft(200,1) calcualted every one time unit at freuquency 0.01
kzft.x1<-kzft(x,200,1,0.005)
x1<-2*Re(kzft.x1$tf[,2])

#kzft(200,2) calcualted every one time unit at freuquency 0.01
kzft.x2<-kzft(x,200,2,0.005/2)
x2<-2*Re(kzft.x2$tf[,2])

#kzft(200,3) calcualted every one time unit at freuquency 0.01
kzft.x3<-kzft(x,200,3,0.005/3)
x3<-2*Re(kzft.x3$tf[,2])

par(mfrow=c(2,2))
plot(x,type="l",main="Original time series",xlab="Time unit", ylab="Amplitude")
plot(x1,type="l",main="kzft(200,1)",xlab="Time unit", ylab="Amplitude")
plot(x2,type="l",main="kzft(200,2)",xlab="Time unit", ylab="Amplitude")
plot(x3,type="l",main="kzft(200,3)",xlab="Time unit", ylab="Amplitude")

}
\keyword{ts}


