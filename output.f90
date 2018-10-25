subroutine output()
  !
  ! save solution
  !
  use m_init

  implicit none

  integer :: i
  integer, parameter :: out_unit = 10
  
  open( unit=out_unit, file='solution.dat', status='unknown')

  do i = 1, ncells+1
     write( out_unit, 100) xcell (i)-dx, u1 (i), u (i), p (i)
  end do

100 format( 2x,10(e12.6,'         '))

  close( out_unit )

  write(*,*) 'Solution saved to file.'

end subroutine output
