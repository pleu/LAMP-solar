clear;
va = Variables('latitude', 'Latitude', '(^{o))');
va= va.add('day', 'Day', '');
va= va.add('beta', 'Tilt', '(^{o))');
va= va.add('gamma', 'Azimuth', '(^{o))');


[vg, ind] = va.get('day');