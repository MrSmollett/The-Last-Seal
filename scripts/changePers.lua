function rotateBtnPressed( event ) 
            if ( "ended" == event.phase ) then
                if event.target.id == "rotateLeftBtn" then
                    print( event.target.id )
					count = count - 1

					if math.abs(count) > 3 then
						count = 0
					end

					print(count)

					if math.abs(count) == 0 then
						pers_prew.fill = { type = "image", filename = "assets/changePers/gg"..direct.left[math.abs(count)]..".png" }
						print(count)
						print(direct.left[math.abs(count)])
					elseif math.abs(count) == 1 then
						pers_prew.fill = { type = "image", filename = "assets/changePers/gg"..direct.left[math.abs(count)]..".png" }
						print(count)
						print(direct.left[math.abs(count)])
					elseif math.abs(count) == 2 then
						pers_prew.fill = { type = "image", filename = "assets/changePers/gg"..direct.left[math.abs(count)]..".png" }
						print(count)
						print(direct.left[math.abs(count)])
					elseif math.abs(count) == 3 then
						pers_prew.fill = { type = "image", filename = "assets/changePers/gg"..direct.left[math.abs(count)]..".png" }
						print(count)
						print(direct.left[math.abs(count)])
					end

                elseif event.target.id == "rotateRight" then
                    print( event.target.id )

					count = count + 1

					if math.abs(count) > 3 then
						count = 0
					end

					

					if math.abs(count) == 0 then
						pers_prew.fill = { type = "image", filename = "assets/changePers/gg"..direct.right[math.abs(count)]..".png" }
						print(count)
						print(direct.right[math.abs(count)])
					elseif math.abs(count) == 1 then
						pers_prew.fill = { type = "image", filename = "assets/changePers/gg"..direct.right[math.abs(count)]..".png" }
						print(count)
						print(direct.right[math.abs(count)])
					elseif math.abs(count) == 2 then
						pers_prew.fill = { type = "image", filename = "assets/changePers/gg"..direct.right[math.abs(count)]..".png" }
						print(count)
						print(direct.right[math.abs(count)])
					elseif math.abs(count) == 3 then
						pers_prew.fill = { type = "image", filename = "assets/changePers/gg"..direct.right[math.abs(count)]..".png" }
						print(count)
						print(direct.right[math.abs(count)])
					end
                end
            end
        end

        function UIBtnPressed(event)
            if ( "ended" == event.phase ) then
                if event.target.id == "logBtn" then
                    print(event.target.id)
                elseif event.target.id == "accBtn" then
                    print(event.target.id)
                elseif event.target.id == "settingsBtn" then
                    print(event.target.id)
                end
            end
        end