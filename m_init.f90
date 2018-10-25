module m_init
  !
  ! definition and initialization of varibles
  !
  use m_double
  
  implicit none

  integer, parameter :: ncells = 100
  integer :: niter
  
  real( kind=dp ), parameter :: gamma = 1.4  
  real( kind=dp ) :: xinit, xend, dx, dt, tinit, tend, lambda
  
  real( kind=dp ), dimension( 0:ncells+2 ) :: xcell
  real( kind=dp ), dimension( 0:ncells+2 ) :: u1, u2, u3   ! conservative variables rho, rho u, rho et
  real( kind=dp ), dimension( 0:ncells+2 ) :: u, p, a
  
  real( kind=dp ), dimension( 0:ncells+1 ) :: f1, f2, f3   ! numerical fluxes

end module m_init
