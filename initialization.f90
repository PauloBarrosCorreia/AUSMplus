subroutine initialization()
  !
  ! initialization of shock tube test variables
  !
  use m_init
  
  implicit none

  integer :: i
  real( kind=dp ) :: ul, ur, pl, pr, al, ar, diaph
  real( kind=dp ) :: rhol, rhor, rhoul, rhour, rhohtl, rhohtr, rhoetl, rhoetr

  u1 = 0.
  u2 = 0.
  u3 = 0.

  f1 = 0.
  f2 = 0.
  f3 = 0.

  u = 0.
  p = 0.
  a = 0.

  xcell = 0.

  xinit = 0.0
  xend = 1.0
  
  dt = 1e-4                              
  dx = ( xend-xinit ) / dble( ncells)

  lambda = dt/dx

  tinit = 0.
  tend = 0.25
  niter = int( (tend-tinit)/dt )

  diaph = 0.5

  rhol = 1.0
  rhor = 0.125

  ul = 0.75
  ur = 0.
  
  pl = 1.0
  pr = 0.1

  al = sqrt( gamma * pl / rhol )
  ar = sqrt( gamma * pr / rhor )

  ! convert primitive to conservative variables --------------------------------
  rhoul = rhol * ul
  rhour = rhor * ur
  
  rhoetl = 0.5 * rhoul*ul + pl/(gamma-1.)
  rhoetr = 0.5 * rhour*ur + pr/(gamma-1.)

  do i = 0, ncells+2                  
     xcell (i) = i * dx

     if (xcell (i) <= diaph) then
        u1 (i) = rhol                 
        u2 (i) = rhoul
        u3 (i) = rhoetl
     elseif (xcell (i) > diaph) then
        u1 (i) = rhor
        u2 (i) = rhour
        u3 (i) = rhoetr
     end if

  end do

end subroutine initialization
