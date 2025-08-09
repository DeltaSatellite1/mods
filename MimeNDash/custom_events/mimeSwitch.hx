function onEvent(n, v1, v2)
{
    if(n == 'mimeSwitch') {
        if(v1 == 'TRUE') {
            game.getLuaObject('bonbon').animation.play('trans-to-shift', false);
            game.getLuaObject('bonbon').offset.x = 70;
            game.getLuaObject('bonbon').offset.y = -70;
            game.getLuaObject('bonbon').animation.finishCallback = function(name) {
                switch(name) {
                    case 'trans-to-shift':
                        game.getLuaObject('bonbon').animation.play('idle-shift', false);
            		game.getLuaObject('bonbon').offset.x = -365;
            		game.getLuaObject('bonbon').offset.y = -85;
                }
            };

            game.getLuaObject('chuchu').animation.play('trans-to-shift', false);
            game.getLuaObject('chuchu').offset.x = -130;
            game.getLuaObject('chuchu').offset.y = -26;
            game.getLuaObject('chuchu').animation.finishCallback = function(name) {
                switch(name) {
                    case 'trans-to-shift':
                        game.getLuaObject('chuchu').animation.play('idle-shift', false);
            		game.getLuaObject('chuchu').offset.x = -150;
            		game.getLuaObject('chuchu').offset.y = 0;
                }
            };
        } else if(v1 == 'FALSE') {
            game.getLuaObject('bonbon').animation.play('trans-to-idle', false);
            game.getLuaObject('bonbon').offset.x = -150;
            game.getLuaObject('bonbon').offset.y = -55;
            game.getLuaObject('bonbon').animation.finishCallback = function(name) {
                switch(name) {
                    case 'trans-to-idle':
                        game.getLuaObject('bonbon').animation.play('idle', true);
            		game.getLuaObject('bonbon').offset.x = -195;
            		game.getLuaObject('bonbon').offset.y = -150;
                }
            };

            game.getLuaObject('chuchu').animation.play('trans-to-idle', false);
            game.getLuaObject('chuchu').offset.x = -150;
            game.getLuaObject('chuchu').offset.y = -30;
            game.getLuaObject('chuchu').animation.finishCallback = function(name) {
                switch(name) {
                    case 'trans-to-idle':
                        game.getLuaObject('chuchu').animation.play('idle', true);
            		game.getLuaObject('chuchu').offset.x = -250;
            		game.getLuaObject('chuchu').offset.y = -170;
                }
            };
        }
    }
}