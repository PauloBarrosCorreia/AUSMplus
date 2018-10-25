subroutine update()
  !
  ! update solution
  !
  use m_init

  implicit none

  integer :: i

  do i = 1, ncells+1
     u1 (i) = u1 (i) - lambda * ( f1 (i) - f1 (i-1) )
     u2 (i) = u2 (i) - lambda * ( f2 (i) - f2 (i-1) )
     u3 (i) = u3 (i) - lambda * ( f3 (i) - f3 (i-1) )
     
     u (i) = u2 (i) / u1 (i)
     p (i) = (gamma-1.) * ( u3 (i) - 0.5 * u2 (i) * u2 (i) / u1 (i) )  
     a (i) = sqrt( gamma * p (i) / u1 (i) )
  end do

  ! updating values at the ghost cells -----------------------------------------
  
  u1 (0) = u1 (1)
  u2 (0) = u2 (1)
  u3 (0) = u3 (1)

  u1 (ncells+2) = u1 (ncells+1)
  u2 (ncells+2) = u2 (ncells+1)
  u3 (ncells+2) = u3 (ncells+1)  

end subroutine update
