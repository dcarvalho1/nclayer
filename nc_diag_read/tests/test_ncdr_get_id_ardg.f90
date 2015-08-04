! Use NCIDs and keep track of things ourselves!
! arda:
!   -> ALLOCATE dimensions by fetching dimensions and allocating
!   -> RETURN DIM: dimension fetching method by returning dimensions
!   -> ALLOCATED: allocated dimensions manually with ndims before fetch
program test_ncdr_get_id_arda
    use nc_diag_read
    use netcdf
    
    integer(i_long) :: ncid_1, ncid_2
    
    !------------------------------------------------------------------
    ! Subroutine allocation method testing
    !------------------------------------------------------------------
    
    ncid_1 = nc_diag_read_id_init("test.nc")
    ncid_2 = nc_diag_read_id_init("test_fixed.nc")
    
    call display_1d_var_long(ncid_1, "chaninfosimple1")
    call display_1d_var_long(ncid_1, "chaninfosimple2")
    
    ! This won't work due to mismatched types:
    !call display_1d_var_byte(ncid_1, "chaninfosimple2")
    
    call display_1d_var_float(ncid_1, "chaninfosimple4_float")
    
    ! Mismatched types:
    !call display_1d_var_long(ncid_1, "chaninfosimple4_float")
    !call display_1d_var_double(ncid_1, "chaninfosimple4_float")
    
    call display_1d_var_double(ncid_1, "chaninfosimple5_double")
    
    call display_1d_var_string(ncid_1, "chaninfosimple6_str")
    call display_1d_var_string(ncid_1, "chaninfosimple7_str")
    
    call display_1d_var_long(ncid_1, "chaninfosimple3_notcomplete")
    
    call display_1d_var_string(ncid_1, "chaninfosimple8_str")
    
    call display_1d_var_long(ncid_1, "chaninfosimple9_buf")
    call display_1d_var_long(ncid_1, "chaninfosimple10_notcomplete")
    
    call display_1d_var_long(ncid_1, "metadatasimple1")
    
    call display_1d_var_string(ncid_1, "metadatasimple6_str")
    call display_1d_var_string(ncid_1, "metadatasimple8_str")
    
    call display_1d_var_long(ncid_1, "metadata_notcomplete")
    
    call display_1d_var_string(ncid_1, "metadata_str_notcomplete")
    
    call display_2d_var_long(ncid_1, "data2dsimple1")
    call display_2d_var_long(ncid_1, "data2dsimple2")
    
    call display_2d_var_float(ncid_1, "data2dsimple4_float")
    call display_2d_var_float(ncid_1, "data2dsimple4_float2")
    
    call display_2d_var_double(ncid_1, "data2dsimple5_double")
    
    call display_2d_var_long(ncid_1, "data2dsimple99")
    
    call display_2d_var_string(ncid_1, "data2dsimple6_str")
    
    call display_2d_var_long(ncid_1, "data2dsimple7")
    call display_2d_var_long(ncid_1, "data2d_notcomplete")
    
    ! ncid #2
    call display_1d_var_string(ncid_2, "chaninfo_strfix")
    call display_1d_var_string(ncid_2, "chaninfo_strfix1")
    call display_1d_var_string(ncid_2, "metadata_strfix")
    call display_1d_var_string(ncid_2, "metadata_strfix1")
    
    call display_2d_var_string(ncid_2, "data2d_strfix")
    call display_2d_var_string(ncid_2, "data2d_strfix1")
    
    ! This doesn't work, since we are tracking our own NCID.
    !call nc_diag_read_close
    
    call nc_diag_read_close(file_ncid = ncid_1)
    call nc_diag_read_close(file_ncid = ncid_2)
    
    ! This won't work - can't close twice!
    !call nc_diag_read_close(file_ncid = ncid_2)
    
    contains
        subroutine display_1d_var_byte(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            integer(i_byte), dimension(:), allocatable :: var_stor
            
            integer(i_long) :: i
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (1D): " // var_name // " (Elements: ", size(var_stor), ")"
            
            !print *, var_stor
            
            !do i = 1, size(var_stor)
            !    if (var_stor(i) == NF90_FILL_INT) then
            !        write (*, "(A5)", advance = "no") "(em) "
            !    else
            !        write (*, "(I4, A)", advance = "no") var_stor(i), " "
            !    end if
            !end do
            
            do i = 1, size(var_stor)
                if (var_stor(i) == NF90_FILL_INT) then
                    write (*, "(A4)") "(em)"
                else
                    write (*, "(I4)") var_stor(i)
                end if
            end do
            
            write (*, "(A)") ""
        end subroutine display_1d_var_byte
        
        subroutine display_1d_var_short(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            integer(i_short), dimension(:), allocatable :: var_stor
            
            integer(i_long) :: i
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (1D): " // var_name // " (Elements: ", size(var_stor), ")"
            
            !print *, var_stor
            
            !do i = 1, size(var_stor)
            !    if (var_stor(i) == NF90_FILL_INT) then
            !        write (*, "(A7)", advance = "no") "(emp) "
            !    else
            !        write (*, "(I6, A)", advance = "no") var_stor(i), " "
            !    end if
            !end do
            
            do i = 1, size(var_stor)
                if (var_stor(i) == NF90_FILL_INT) then
                    write (*, "(A6)") "(emp)"
                else
                    write (*, "(I6)") var_stor(i)
                end if
            end do
            
            write (*, "(A)") ""
        end subroutine display_1d_var_short
        
        subroutine display_1d_var_long(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            integer(i_long), dimension(:), allocatable :: var_stor
            
            integer(i_long) :: i
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (1D): " // var_name // " (Elements: ", size(var_stor), ")"
            !print *, var_stor
            
            !do i = 1, size(var_stor)
            !    if (var_stor(i) == NF90_FILL_INT) then
            !        write (*, "(A13)", advance = "no") "(empty) "
            !    else
            !        write (*, "(I12, A)", advance = "no") var_stor(i), " "
            !    end if
            !end do
            
            do i = 1, size(var_stor)
                if (var_stor(i) == NF90_FILL_INT) then
                    write (*, "(A12)") "(empty) "
                else
                    write (*, "(I12)") var_stor(i)
                end if
            end do
            
            write (*, "(A)") ""
            
        end subroutine display_1d_var_long
        
        subroutine display_1d_var_float(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            real(r_single), dimension(:), allocatable  :: var_stor
            
            integer(i_long) :: i
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (1D): " // var_name // " (Elements: ", size(var_stor), ")"
            !print *, var_stor
            
            !do i = 1, size(var_stor)
            !    if (var_stor(i) == NF90_FILL_FLOAT) then
            !        write (*, "(A19)", advance = "no") "(empty) "
            !    else
            !        write (*, "(F18.10, A)", advance = "no") var_stor(j, i), " "
            !    end if
            !end do
            
            do i = 1, size(var_stor)
                if (var_stor(i) == NF90_FILL_FLOAT) then
                    write (*, "(A18)") "(empty)"
                else
                    write (*, "(F18.10)") var_stor(i)
                end if
            end do
        end subroutine display_1d_var_float
        
        subroutine display_1d_var_double(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            real(r_double), dimension(:), allocatable  :: var_stor
            
            integer(i_long) :: i
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (1D): " // var_name // " (Elements: ", size(var_stor), ")"
            !print *, var_stor
            
            !do i = 1, size(var_stor)
            !    if (var_stor(i) == NF90_FILL_FLOAT) then
            !        write (*, "(A17)", advance = "no") "(empty) "
            !    else
            !        write (*, "(F16.13, A)", advance = "no") var_stor(j, i), " "
            !    end if
            !end do
            
            do i = 1, size(var_stor)
                if (var_stor(i) == NF90_FILL_DOUBLE) then
                    write (*, "(A16)") "(empty)"
                else
                    write (*, "(F16.13)") var_stor(i)
                end if
            end do
        end subroutine display_1d_var_double
        
        subroutine display_1d_var_string(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            character(len=:), dimension(:), allocatable:: var_stor
            
            integer(i_long) :: i, dim_1, dim_2
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            dim_1 = var_dims(1)
            dim_2 = var_dims(2)
            allocate(character(len=dim_1) :: var_stor(dim_2))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (1D): " // var_name // " (Elements: ", size(var_stor), ")"
            
            !do i = 1, size(var_stor)
            !    if ((i > 1) .AND. (mod(i - 1, 5) == 0)) write (*, "(A)") ""
            !    if ((var_stor(i)(1:1) == NF90_FILL_CHAR) .OR. (len(var_stor(i)) == 0)) then
            !        write (*, "(A20)", advance = "no") "(empty) "
            !    else
            !        write (*, "(A20)", advance = "no") '"' // var_stor(i) // '" '
            !    end if
            !end do
            
            do i = 1, size(var_stor)
                if ((var_stor(i)(1:1) == NF90_FILL_CHAR) .OR. (len(var_stor(i)) == 0)) then
                    write (*, "(A20)") "(empty)"
                else
                    write (*, "(A20)") '"' // var_stor(i) // '"'
                end if
            end do
            
            write (*, "(A)") ""
            
        end subroutine display_1d_var_string
        
        subroutine display_2d_var_byte(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            integer(i_byte),dimension(:,:),allocatable :: var_stor
            
            integer(i_long) :: i, j
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1), var_dims(2)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (2D): " // var_name // " (Elements: ", size(var_stor), ")"
            
            do i = 1, size(var_stor, 2)
                do j = 1, size(var_stor, 1)
                    if ((j > 1) .AND. (mod(j - 1, 5) == 0)) write (*, "(A)") "..."
                    if (var_stor(j, i) == NF90_FILL_BYTE) then
                        write (*, "(A5)", advance = "no") "(e) "
                    else
                        write (*, "(I4, A)", advance = "no") var_stor(j, i), " "
                    end if
                end do
                write (*, "(A)") ""
            end do
        end subroutine display_2d_var_byte
        
        subroutine display_2d_var_short(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            integer(i_short),dimension(:,:),allocatable :: var_stor
            
            integer(i_long) :: i, j
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1), var_dims(2)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (2D): " // var_name // " (Elements: ", size(var_stor), ")"
            
            do i = 1, size(var_stor, 2)
                do j = 1, size(var_stor, 1)
                    if ((j > 1) .AND. (mod(j - 1, 5) == 0)) write (*, "(A)") "..."
                    if (var_stor(j, i) == NF90_FILL_SHORT) then
                        write (*, "(A7)", advance = "no") "(emp) "
                    else
                        write (*, "(I6, A)", advance = "no") var_stor(j, i), " "
                    end if
                end do
                write (*, "(A)") ""
            end do
        end subroutine display_2d_var_short
        
        subroutine display_2d_var_long(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            integer(i_long),dimension(:,:),allocatable :: var_stor
            
            integer(i_long) :: i, j
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1), var_dims(2)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (2D): " // var_name // " (Elements: ", size(var_stor), ")"
            
            do i = 1, size(var_stor, 2)
                do j = 1, size(var_stor, 1)
                    if ((j > 1) .AND. (mod(j - 1, 5) == 0)) write (*, "(A)") "..."
                    if (var_stor(j, i) == NF90_FILL_INT) then
                        write (*, "(A13)", advance = "no") "(empty) "
                    else
                        write (*, "(I12, A)", advance = "no") var_stor(j, i), " "
                    end if
                end do
                write (*, "(A)") ""
            end do
        end subroutine display_2d_var_long
        
        subroutine display_2d_var_float(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            real(r_single), dimension(:,:), allocatable:: var_stor
            
            integer(i_long) :: i, j
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1), var_dims(2)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (2D): " // var_name // " (Elements: ", size(var_stor), ")"
            
            do i = 1, size(var_stor, 2)
                do j = 1, size(var_stor, 1)
                    if ((j > 1) .AND. (mod(j - 1, 5) == 0)) write (*, "(A)") "..."
                    if (var_stor(j, i) == NF90_FILL_FLOAT) then
                        write (*, "(A19)", advance = "no") "(empty) "
                    else
                        write (*, "(F18.10, A)", advance = "no") var_stor(j, i), " "
                    end if
                end do
                write (*, "(A)") ""
            end do
        end subroutine display_2d_var_float
        
        subroutine display_2d_var_double(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            real(r_double), dimension(:,:), allocatable:: var_stor
            
            integer(i_long) :: i, j
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            allocate(var_stor(var_dims(1), var_dims(2)))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (2D): " // var_name // " (Elements: ", size(var_stor), ")"
            
            do i = 1, size(var_stor, 2)
                do j = 1, size(var_stor, 1)
                    if ((j > 1) .AND. (mod(j - 1, 5) == 0)) write (*, "(A)") "..."
                    if (var_stor(j, i) == NF90_FILL_DOUBLE) then
                        write (*, "(A17)", advance = "no") "(empty) "
                    else
                        write (*, "(F16.13, A)", advance = "no") var_stor(j, i), " "
                    end if
                end do
                write (*, "(A)") ""
            end do
            
        end subroutine display_2d_var_double
        
        ! NOTE - dimensions have to be flipped
        subroutine display_2d_var_string(ncid, var_name)
            integer(i_long), intent(in)                :: ncid
            character(len=*)                           :: var_name
            character(len=:),dimension(:,:),allocatable:: var_stor
            
            integer(i_long) :: i, j, dim_1, dim_2, dim_3
            integer(i_long), dimension(:), allocatable :: var_dims
            
            call nc_diag_read_get_var_dims(ncid, var_name, var_dims = var_dims)
            
            dim_1 = var_dims(1)
            dim_2 = var_dims(2)
            dim_3 = var_dims(3)
            
            allocate(character(len=dim_1) :: var_stor(dim_2, dim_3))
            
            call nc_diag_read_get_var(ncid, var_name, var_stor)
            
            write (*, "(A, I0, A)") " ** Variable (2D): " // var_name // " (Elements: ", size(var_stor), ")"
            
            print *, shape(var_stor)
            
            do i = 1, size(var_stor, 2)
                do j = 1, size(var_stor, 1)
                    if ((j > 1) .AND. (mod(j - 1, 5) == 0)) write (*, "(A)") "..."
                    if ((var_stor(j, i)(1:1) == NF90_FILL_CHAR) .OR. (len(var_stor(j, i)) == 0)) then
                        write (*, "(A20)", advance = "no") "(empty) "
                    else
                        write (*, "(A20)", advance = "no") '"' // var_stor(j, i) // '" '
                    end if
                end do
                write (*, "(A)") ""
            end do
            
            write (*, "(A)") ""
            
        end subroutine display_2d_var_string
end program test_ncdr_get_id_arda
