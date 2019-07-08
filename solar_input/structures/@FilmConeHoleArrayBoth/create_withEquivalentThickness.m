function filmConeHoleArray = create_withEquivalentThickness(equivalentThickness, zSpan, xSpan, TopConezSpan, Toprtop, Toprbot, ntop, Botrtop, Botrbot, nbot)
   
    BotConezSpan = (3*xSpan^2*(zSpan- equivalentThickness)/pi-(Toprtop^2+Toprtop*Toprbot+Toprbot^2)*TopConezSpan*ntop^2)/((Botrtop^2+Botrtop*Botrbot+Botrbot^2)*nbot^2);
    
    filmConeHoleArray = FilmConeHoleArrayBoth(zSpan, xSpan, TopConezSpan, Toprtop, Toprbot, BotConezSpan, Botrtop, Botrbot);
end
