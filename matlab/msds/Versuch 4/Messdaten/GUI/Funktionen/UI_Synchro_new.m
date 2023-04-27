function UI_Synchro_new(src,evt,UI)

    global Flag_Synchro Offset_Synchro_xlin Offset_Synchro_xrot

    if (src.Value == 1)
        Flag_Synchro = false;
        UI.Synchro_edit.BackgroundColor = [0.94 0.94 0.94];
        UI.Synchro_new.BackgroundColor = [0.94 0.94 0.94];
        src.Visible = 'off';
        Offset_Synchro_xlin = 0;
        Offset_Synchro_xrot = 0;
    end
end