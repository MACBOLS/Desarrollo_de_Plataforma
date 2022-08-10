echo INSTALADOR DE LA BASE DE DATOS
echo Autor: Durand Castro
echo 08/08/22
sqlcmd -S. -E -i BDUniversidad.sql
sqlcmd -S. -E -i BDUniversidadPA.sql
echo SE EJECUTO CORRECTAMENTE
pause 