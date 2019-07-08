function filmConeHole = create_withEquivalentThickness(equivalentThickness, zSpan, xSpan, TopConezSpan, Toprtop, Toprbot, Botrtop, Botrbot)
    BotConezSpan = (3*xSpan^2*(zSpan- equivalentThickness)/pi-(Toprtop^2+Toprtop*Toprbot+Toprbot^2)*TopConezSpan)/(Botrtop^2+Botrtop*Botrbot+Botrbot^2);
    filmConeHole = FilmConeHoleBoth(zSpan, xSpan, TopConezSpan, Toprtop, Toprbot, BotConezSpan, Botrtop, Botrbot);
end
