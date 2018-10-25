subroutine ausmplus()
  !
  ! Implementation of AUSM+
  !
  use m_init

  implicit none

  integer :: j
  real( kind=dp ) :: rhol, rhor, ul, ur, htl, htr
  real( kind=dp ) :: astarsqrl, astarsqrr, astarl, astarr, atildel, atilder, ajplushalf
  real( kind=dp ) :: Mj, Mjp1, Mplus, Mminus, mjplushalf, mjplushalfplus, mjplushalfminus
  real( kind=dp ) :: pl, pr, pj, pjp1, Pplus, Pminus, Pjplushalf

  do j = 0, ncells+1

     ! compute ajplushalf ------------------------------------------------------

     rhol = u1 (j)
     rhor = u1 (j+1)
     
     ul  = u2 (j) / rhol
     ur  = u2 (j+1) / rhor

     pl = (gamma-1.) * ( u3 (j) - 0.5 * u2 (j) * u2 (j) / u1 (j) )               
     pr = (gamma-1.) * ( u3 (j+1) - 0.5 * u2 (j+1) * u2 (j+1) / u1 (j+1) )   

     htl = (u3 (j) + pl) / rhol
     htr = (u3 (j+1) + pr) / rhor
     
     astarsqrl = 2. * htl * (gamma-1.) / (gamma+1.)
     astarsqrr = 2. * htr * (gamma-1.) / (gamma+1.)

     astarl = sqrt( astarsqrl )
     astarr = sqrt( astarsqrr )

     atildel = astarsqrl / (max( astarl, abs( ul ) ) )
     atilder = astarsqrr / (max( astarr, abs( ur ) ) )

     ajplushalf = min( atildel, atilder )

     ! compute mjplushalfplus and mjplushalfminus ------------------------------

     Mj = ul / ajplushalf
     Mjp1     = ur / ajplushalf

     if (abs( Mj) >= 1.) then
        Mplus = 0.5* ( Mj + abs( Mj) )
     else
        Mplus = 0.5 * (Mj +1.)*(Mj +1.) + 0.125 * (Mj*Mj-1.)* (Mj*Mj-1.)
     end if

     if (abs( Mjp1 ) >= 1.) then
        Mminus = 0.5* ( Mjp1 + abs( Mjp1 ) )
     else
        Mminus = -0.5 * (Mjp1 - 1.) * (Mjp1 - 1.) - 0.125 * (Mjp1*Mjp1 - 1.)* (Mjp1*Mjp1 - 1.)
     end if

     mjplushalf = Mplus + Mminus
     
     mjplushalfplus  = 0.5 * (mjplushalf + abs( mjplushalf ) )
     mjplushalfminus = 0.5 * (mjplushalf - abs( mjplushalf ) )

     ! compute pjplushalf ------------------------------------------------------

     pj   = pl
     pjp1 = pr

     if (abs( Mj ) >= 1.) then
        Pplus = 0.5* ( 1. + sign( 1.0_dp, Mj) )
     else
        Pplus = 0.25 * (Mj +1.) * (Mj +1.) * ( 2. - Mj) + 0.1875 * Mj * (Mj*Mj - 1.) * (Mj*Mj - 1.)
     end if

     if (abs( Mjp1 ) >= 1.) then
        Pminus = 0.5* ( 1. - sign( 1.0_dp, Mjp1) )
     else
        Pminus = 0.25 * (Mjp1 - 1.)*(Mjp1 - 1.) * ( 2. + Mjp1) - 0.1875 * Mjp1 * (Mjp1*Mjp1 - 1.) * (Mjp1*Mjp1 - 1.)
     end if     
     
     Pjplushalf = Pplus * pj + Pminus * pjp1

     ! compute numerical fluxes ------------------------------------------------

     f1 (j) = ajplushalf * ( mjplushalfplus * u1 (j) + mjplushalfminus * u1 (j+1) )
     f2 (j) = ajplushalf * ( mjplushalfplus * u2 (j) + mjplushalfminus * u2 (j+1) ) + Pjplushalf
     f3 (j) = ajplushalf * ( mjplushalfplus * htl    + mjplushalfminus * htr )

  end do

end subroutine ausmplus
