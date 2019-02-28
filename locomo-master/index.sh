#!/bin/bash
while :
do
  clear
  echo "1. Iniciar Sesión"
  echo "2. Registrarse"
  echo "3. Salir"
  echo
  echo -n "¿Opción? "
  read op
  case "$op" in
      1)
        #Iniciar Sesión
        /usr/bin/resize -s 26 56
        registro="0"
        until [ $registro -eq 1 ];
        do
          clear
          if [ $registro -eq 2 ];
          then
            echo "INICIAR SESIÓN  *Usuario Incorrecto"
          elif [ $registro -eq 3 ];
          then
            echo "INICIAR SESIÓN  *Contraseña Incorrecta"
          else
            echo "INICIAR SESIÓN"
          fi
          echo
          echo -n "Usuario: "
          read usuario
          echo
          echo -n "Contraseña: "
          read -s contrasena
          if [ -f "bd/usuarios/$usuario.txt" ];
          then
            reclamar=`cat "bd/usuarios/$usuario.txt" | grep ^$usuario`
            reclamarc=`echo $reclamar | cut -d ":" -f "2"`
            if [ $reclamarc = $contrasena ];
            then
              clear
              echo -n "Logueado Correctamente"
              sleep 2
              registro=1
              until [ $op -eq 6 ];
              do
                skinM=`cat bd/skins/usuarios/$usuario.txt | cut -d ":" -f2`
                clear
                echo "Sesión: $usuario     Mondedero: $skinM€"
                echo
                echo
                echo "1. Nueva Partida"
                echo "2. Cargar Partida"
                echo "3. Historial de Partidas"
                echo "4. Top 5"
                echo "5. Tienda de Skins"
                echo "6. Salir"
                echo
                echo -n "Opción? "
                read op
                case $op in
                    1)
                      #Nueva Partida
                      clear
                      skin=`cat bd/skins/usuarios/$usuario.txt | cut -d ":" -f1`
                      skinM=`cat bd/skins/usuarios/$usuario.txt | cut -d ":" -f2`
                      puntosN=0
                      vidasN1=3
                      vidasN2="<3 <3 <3"
                      source joc/joc.sh
                      clear
                      echo Has ganado $puntos puntos
                      echo
                      nrecords=`cat "bd/ranking/top.txt" | wc -l`
                      fecha=`date +"%d/%m/%Y"`
                      hora=`date +"%H;%M"`
                      if [[ $guardar -eq 0 ]];
                      then
                        partidasg=`cat bd/usuarios/$usuario.txt | wc -l`
                        echo "$partidasg:$fecha:$hora:$puntos" >> bd/usuarios/$usuario.txt
                        skinM=$(($skinM + $puntos))
                        echo "$skin:$skinM" > bd/skins/usuarios/$usuario.txt
                        if [[ $nrecords -eq 5 ]];
                        then
                          tc1=`cat "bd/ranking/top.txt" | head -1 | tail -1`
                          tc2=`cat "bd/ranking/top.txt" | head -2 | tail -1`
                          tc3=`cat "bd/ranking/top.txt" | head -3 | tail -1`
                          tc4=`cat "bd/ranking/top.txt" | head -4 | tail -1`
                          tc5=`cat "bd/ranking/top.txt" | head -5 | tail -1`
                          t1=`echo $tc1 | cut -d ":" -f5`
                          t2=`echo $tc2 | cut -d ":" -f5`
                          t3=`echo $tc3 | cut -d ":" -f5`
                          t4=`echo $tc4 | cut -d ":" -f5`
                          t5=`echo $tc5 | cut -d ":" -f5`
                          if [[ (($puntos -gt $t5)) && (($puntos -lt $t4)) ]];
                          then
                            echo "$tc1" > bd/ranking/top.txt
                            echo "$tc2" >> bd/ranking/top.txt
                            echo "$tc3" >> bd/ranking/top.txt
                            echo "$tc4" >> bd/ranking/top.txt
                            echo "5:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                            echo Has entrado en el top5
                          elif [[ (($puntos -gt $t4)) && (($puntos -lt $t3)) ]];
                          then
                            campos4=`echo $tc4 | wc -c`
                            campos4=`echo $tc4 | cut -c 3-$campos4`
                            echo "$tc1" > bd/ranking/top.txt
                            echo "$tc2" >> bd/ranking/top.txt
                            echo "$tc3" >> bd/ranking/top.txt
                            echo "4:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                            echo "5:$campos4" >> bd/ranking/top.txt
                            echo Has entrado en el top5
                          elif [[ $puntos -gt $t3 && $puntos -lt $t2 ]];
                          then
                            campos4=`echo $tc4 | wc -c`
                            campos4=`echo $tc4 | cut -c 3-$campos4`
                            campos3=`echo $tc3 | wc -c`
                            campos3=`echo $tc3 | cut -c 3-$campos3`
                            echo "$tc1" > bd/ranking/top.txt
                            echo "$tc2" >> bd/ranking/top.txt
                            echo "3:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                            echo "4:$campos3" >> bd/ranking/top.txt
                            echo "5:$campos4" >> bd/ranking/top.txt
                            echo Has entrado en el top5
                          elif [[ $puntos -gt $t2 && $puntos -lt $t1 ]];
                          then
                            campos4=`echo $tc4 | wc -c`
                            campos4=`echo $tc4 | cut -c 3-$campos4`
                            campos3=`echo $tc3 | wc -c`
                            campos3=`echo $tc3 | cut -c 3-$campos3`
                            campos2=`echo $tc2 | wc -c`
                            campos2=`echo $tc2 | cut -c 3-$campos2`
                            echo "$tc1" > bd/ranking/top.txt
                            echo "2:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                            echo "3:$campos2" >> bd/ranking/top.txt
                            echo "4:$campos3" >> bd/ranking/top.txt
                            echo "5:$campos4" >> bd/ranking/top.txt
                            echo Has entrado en el top5
                          elif [[ $puntos -gt $t1 ]];
                          then
                            campos4=`echo $tc4 | wc -c`
                            campos4=`echo $tc4 | cut -c 3-$campos4`
                            campos3=`echo $tc3 | wc -c`
                            campos3=`echo $tc3 | cut -c 3-$campos3`
                            campos2=`echo $tc2 | wc -c`
                            campos2=`echo $tc2 | cut -c 3-$campos2`
                            campos1=`echo $tc1 | wc -c`
                            campos1=`echo $tc1 | cut -c 3-$campos1`
                            echo "1:$usuario:$fecha:$hora:$puntos" > bd/ranking/top.txt
                            echo "2:$campos1" >> bd/ranking/top.txt
                            echo "3:$campos2" >> bd/ranking/top.txt
                            echo "4:$campos3" >> bd/ranking/top.txt
                            echo "5:$campos4" >> bd/ranking/top.txt
                            echo Has entrado en el top5
                          fi
                        else
                          id=$(($nrecords + 1))
                          echo "Has entrado en el Top5"
                          echo "$id:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                        fi
                      elif [[ $guardar -eq 1 ]];
                      then
                        echo "$puntos:$vidas:$vidasD" >> bd/partides/$usuario.txt
                      fi
                      sleep 2
                    ;;
                    2)
                      #Cargar Partida
                      clear
                      clear
                      puntosN=`cat bd/partides/$usuario.txt | head -1 | cut -d ":" -f1`
                      vidasN1=`cat bd/partides/$usuario.txt | head -1 | cut -d ":" -f2`
                      vidasN2=`cat bd/partides/$usuario.txt | head -1 | cut -d ":" -f3`
                      echo Tenías $puntosN puntos
                      echo Tenías $vidasN2 vidas
                      sleep 2
                      source joc/joc.sh
                      clear
                      echo Has ganado $puntos puntos.
                      read i
                      nrecords=`cat "bd/ranking/top.txt" | wc -l`
                      fecha=`date +"%d/%m/%Y"`
                      hora=`date +"%H;%M"`
                      if [[ $nrecords -eq 5 ]];
                      then
                        tc1=`cat "bd/ranking/top.txt" | head -1 | tail -1`
                        tc2=`cat "bd/ranking/top.txt" | head -2 | tail -1`
                        tc3=`cat "bd/ranking/top.txt" | head -3 | tail -1`
                        tc4=`cat "bd/ranking/top.txt" | head -4 | tail -1`
                        tc5=`cat "bd/ranking/top.txt" | head -5 | tail -1`
                        t1=`echo $tc1 | cut -d ":" -f5`
                        t2=`echo $tc2 | cut -d ":" -f5`
                        t3=`echo $tc3 | cut -d ":" -f5`
                        t4=`echo $tc4 | cut -d ":" -f5`
                        t5=`echo $tc5 | cut -d ":" -f5`
                        if [[ (($puntos -gt $t5)) && (($puntos -lt $t4)) ]];
                        then
                          echo "$tc1" > bd/ranking/top.txt
                          echo "$tc2" >> bd/ranking/top.txt
                          echo "$tc3" >> bd/ranking/top.txt
                          echo "$tc4" >> bd/ranking/top.txt
                          echo "5:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                        elif [[ (($puntos -gt $t4)) && (($puntos -lt $t3)) ]];
                        then
                          campos4=`echo $tc4 | wc -c`
                          campos4=`echo $tc4 | cut -c 3-$campos4`
                          echo "$tc1" > bd/ranking/top.txt
                          echo "$tc2" >> bd/ranking/top.txt
                          echo "$tc3" >> bd/ranking/top.txt
                          echo "4:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                          echo "5:$campos4" >> bd/ranking/top.txt
                        elif [[ $puntos -gt $t3 && $puntos -lt $t2 ]];
                        then
                          campos4=`echo $tc4 | wc -c`
                          campos4=`echo $tc4 | cut -c 3-$campos4`
                          campos3=`echo $tc3 | wc -c`
                          campos3=`echo $tc3 | cut -c 3-$campos3`
                          echo "$tc1" > bd/ranking/top.txt
                          echo "$tc2" >> bd/ranking/top.txt
                          echo "3:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                          echo "4:$campos3" >> bd/ranking/top.txt
                          echo "5:$campos4" >> bd/ranking/top.txt
                        elif [[ $puntos -gt $t2 && $puntos -lt $t1 ]];
                        then
                          campos4=`echo $tc4 | wc -c`
                          campos4=`echo $tc4 | cut -c 3-$campos4`
                          campos3=`echo $tc3 | wc -c`
                          campos3=`echo $tc3 | cut -c 3-$campos3`
                          campos2=`echo $tc2 | wc -c`
                          campos2=`echo $tc2 | cut -c 3-$campos2`
                          echo "$tc1" > bd/ranking/top.txt
                          echo "2:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                          echo "3:$campos2" >> bd/ranking/top.txt
                          echo "4:$campos3" >> bd/ranking/top.txt
                          echo "5:$campos4" >> bd/ranking/top.txt
                        elif [[ $puntos -gt $t1 ]];
                        then
                          campos4=`echo $tc4 | wc -c`
                          campos4=`echo $tc4 | cut -c 3-$campos4`
                          campos3=`echo $tc3 | wc -c`
                          campos3=`echo $tc3 | cut -c 3-$campos3`
                          campos2=`echo $tc2 | wc -c`
                          campos2=`echo $tc2 | cut -c 3-$campos2`
                          campos1=`echo $tc1 | wc -c`
                          campos1=`echo $tc1 | cut -c 3-$campos1`
                          echo "1:$usuario:$fecha:$hora:$puntos" > bd/ranking/top.txt
                          echo "2:$campos1" >> bd/ranking/top.txt
                          echo "3:$campos2" >> bd/ranking/top.txt
                          echo "4:$campos3" >> bd/ranking/top.txt
                          echo "5:$campos4" >> bd/ranking/top.txt
                        fi
                      else
                        id=$(($nrecords + 1))
                        echo "Has entrado en el Top5"
                        echo "$id:$usuario:$fecha:$hora:$puntos" >> bd/ranking/top.txt
                      fi
                      /usr/bin/resize -s 26 56
                      sleep 2
                    ;;
                    3)
                      #Historial de Partidas
                      clear
                      partidasg=`cat bd/usuarios/$usuario.txt | wc -l`
                      echo "Nº    FECHA    HORA    PUNTOS"
                      echo
                      for a in `seq 2 $partidasg`
                      do
                        campo1=`cat bd/usuarios/$usuario.txt | head -$a | tail -1 | cut -d ":" -f1`
                        campo2=`cat bd/usuarios/$usuario.txt | head -$a | tail -1 | cut -d ":" -f2`
                        campo3=`cat bd/usuarios/$usuario.txt | head -$a | tail -1 | cut -d ":" -f3`
                        campo3=`echo $campo3 | tr ";" ":"`
                        campo4=`cat bd/usuarios/$usuario.txt | head -$a | tail -1 | cut -d ":" -f4`
                        echo "$campo1  $campo2  $campo3     $campo4"
                      done
                      read a
                    ;;
                    4)
                      #Top 5
                      clear
                      nrecords=`cat "bd/ranking/top.txt" | wc -l`
                      echo "Nº  USUARIO     FECHA     HORA     PUNTOS"
                      echo
                      for a in `seq $nrecords`
                      do
                        campo1=`cat "bd/ranking/top.txt" | head -$a | tail -1 | cut -d ":" -f1`
                        campo2=`cat "bd/ranking/top.txt" | head -$a | tail -1 | cut -d ":" -f2`
                        campo3=`cat "bd/ranking/top.txt" | head -$a | tail -1 | cut -d ":" -f3`
                        campo4=`cat "bd/ranking/top.txt" | head -$a | tail -1 | cut -d ":" -f4`
                        campo4=`echo $campo4 | tr ";" ":"`
                        campo5=`cat "bd/ranking/top.txt" | head -$a | tail -1 | cut -d ":" -f5`
                        echo "$campo1   $campo2    $campo3  $campo4     $campo5"
                      done
                      read a
                    ;;
                    5)
                      #Tienda de `cat bd/skins/tienda/skins.txt | head -$a | tail -1 | cut -d":" -f3`Skins
                      clear
                      skins=`cat bd/skins/tienda/skins.txt | wc -l`
                      echo "Nº  SKIN  PRECIO"
                      echo
                      for a in `seq $skins`
                      do
                        echo -n "`cat bd/skins/tienda/skins.txt | head -$a | tail -1 | cut -d":" -f1`   "
                        echo -n "`cat bd/skins/tienda/skins.txt | head -$a | tail -1 | cut -d":" -f2`   "
                        echo "`cat bd/skins/tienda/skins.txt | head -$a | tail -1 | cut -d":" -f3`"
                      done
                      echo
                      echo 0 para cancelar
                      echo -n "Nº de la SKIN que quieres comprar? "
                      read nskin
                      if [[ $nskin -eq 0 ]];
                      then
                        a=1
                      else
                        skin=`cat bd/skins/tienda/skins.txt | head -$nskin | tail -1 | cut -d":" -f2`
                        skinC=`cat bd/skins/tienda/skins.txt | head -$nskin | tail -1 | cut -d":" -f3`
                        skinC=`echo $skinC | tr -d "€"`
                        skinM=`cat bd/skins/usuarios/$usuario.txt | cut -d ":" -f2`
                        if [[ "$skinC" -le "$skinM" ]];
                        then
                          clear
                          skinM=$(($skinM - $skinC))
                          echo "$skin:$skinM" > bd/skins/usuarios/$usuario.txt
                          echo "Skin $skin comprada. Saldo restante: $skinM€"
                          sleep 2
                        else
                          clear
                          echo No tienes suficientes €
                          sleep 2
                        fi
                      fi
                    ;;
                    6)
                      #salir
                      clear
                    ;;
                esac
              done
            else
              registro=3
            fi
          else
            registro=2
          fi
        done
      ;;
      2)
        #Registrarse
        registro="0"
        until [ $registro -eq 1 ];
        do
          clear
          if [ $registro -eq 2 ];
          then
            echo "REGISTRO  *El usuario ya existe"
          else
            echo "REGISTRO"
          fi
          echo
          echo -n "Usuario: "
          read usuario
          echo
          echo -n "Contraseña: "
          read -s contrasena
          eusuario=`echo`
          if [ -f "bd/usuarios/$usuario.txt" ];
          then
            registro=2
          else
            clear
            echo "$usuario:$contrasena" >> "bd/usuarios/$usuario.txt"
            echo "WWW:0" >> "bd/skins/usuarios/$usuario.txt"
            echo -n "Usuario Registrado"
            sleep 2
            registro=1
          fi
        done
      ;;
      3)
        #salir
        clear
        exit
      ;;
      4)
      shutdown now
      ;;
      admin)
        echo -n "Contraseña: "
        read contrasena
        if [[ $contrasena -eq "1212" ]];
        then
          clear
          echo "Bienvenido Administrador"
          echo
          echo "1. Gestionar Tienda"
          echo "2. Abrir repositorio Github"
          echo
          echo -n "Opción? "
          read op
          case $op in
              1)
                clear
                echo "Gestionar Tienda"
                echo
                echo "1. Añadir Skin"
                echo "2. Borrar Skin"
                echo
                echo -n "Opción? "
                read op
                case $op in
                    1)
                      clear
                      w=`cat bd/skins/tienda/skins.txt | wc -l`
                      w=$(($w + 1))
                      clear
                      echo  -n "Escriba la skin que quiera añadir: "
                      read skin
                      echo  -n "Escriba el precio de la skin $skin: "
                      read precioskin
                      echo "$w:$skin:$precioskin€" >> "bd/skins/tienda/skins.txt"

                    ;;
                    2)
                      clear
                      echo -n "Numero de la linea de la skin que desea borrar: "
                      read borrarskin
                      sed -i".bak" $borrarskin bd/skins/tienda/skins.txt
                      sleep 2
                      echo "La skin ha sido borrada."
                      read sknb

                    ;;
                esac
              ;;
          esac
        fi
      ;;
    esac
done
