net.Receive("war_panel", function()
    local selectedValue = "" 
    local Frame = vgui.Create( "DFrame" )
	Frame:SetPos((ScrW() / 2) - 150, (ScrH() / 2) - 40)
	Frame:SetSize( 300, 80 )
	Frame:SetTitle( "3FX War System" )
	Frame:SetVisible( true )
	Frame:SetDraggable( false )
	Frame:ShowCloseButton( true )
	Frame:MakePopup()

    local Reason = vgui.Create( "DTextEntry", Frame )
    Reason:SetPos( 5, 25 )
    Reason:SetSize( 185, 20 )
    Reason:SetText( "Reason for war" )

    local DComboBox = vgui.Create( "DComboBox", Frame )
    DComboBox:SetPos( 195, 25 )
    DComboBox:SetSize( 100, 20 )
    DComboBox:SetValue( "Factions" )
    DComboBox:AddChoice( "USA" )
    DComboBox:AddChoice( "Russia" )
    DComboBox:AddChoice( "China" )
    DComboBox.OnSelect = function( self, index, value )
        selectedValue = value
    end

	local declareButton = vgui.Create( "DButton", Frame )
	declareButton:SetText( "Declare War" )
	declareButton:SetTextColor( Color( 0, 0, 0 ) )
	declareButton:SetPos( 5, 48 )
	declareButton:SetSize( 145, 30 )
	declareButton.DoClick = function()
        net.Start("declare_war")
        net.WriteString(team.GetName(LocalPlayer():Team()))
        net.WriteString(selectedValue)
        net.WriteString(Reason:GetValue())
        net.SendToServer()
		Frame:Close()
    end
    
    local endButton = vgui.Create( "DButton", Frame )
	endButton:SetText( "End War" )
	endButton:SetTextColor( Color( 0, 0, 0 ) )
	endButton:SetPos( 150, 48 )
	endButton:SetSize( 145, 30 )
	endButton.DoClick = function()
        net.Start("end_war")
        net.WriteString(team.GetName(LocalPlayer():Team()))
        net.WriteString(selectedValue)
        net.SendToServer()
		Frame:Close()
	end

	
end)