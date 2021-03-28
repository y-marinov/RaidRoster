SLASH_ROSTER1 = "/roster"
SlashCmdList["ROSTER"] = function()
    StaticPopup_Show("ROSTER_DIALOG")
end

function getRoster()
    local names = {}
    for i = 1, 30 do
        names[i] = GetRaidRosterInfo(i)
    end
    names_string = date("%d/%m/%y")
    for i, name in ipairs(names) do
        names_string = names_string .. '\r' .. name
    end
    return names_string
end

StaticPopupDialogs["ROSTER_DIALOG"] = {
    OnShow = function(self, data)
        roster = getRoster()
        self.editBox:SetText(roster)
        self.editBox:SetScript("OnTextChanged", function()
            self.editBox:SetText(roster)
            self.editBox:HighlightText()
            self.editBox:SetFocus()
        end)
        self.editBox:HighlightText()
        self.editBox:SetFocus()
        self.editBox:SetScript("OnEscapePressed", function()
            self.editBox:Hide()
            self:Hide()
        end)
    end,
    text = "Press CTRL+C, then click OK and paste the result in Discord:",
    button1 = "OK",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    hasEditBox = true,
    preferredIndex = 3 -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}