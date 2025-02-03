# ``UnixFitSDK``

Фреймворк для поиска, коннекта, получения и отправки данных на тренажеры, использующие протокол FTMS.

## Overview

Для добавления фреймворка в свой проект выполните следующие шаги:
1. Перетащите UnixFitSDK.framework к себе в проект.
2. Перейдите в свойства проекта на вкладку General
3. В пункте "Frameworks, Libraries, and Embedded content" измените свойство Embed на Embed & Sign у UnixFitSDK.framework

Для начала работы с фреймворком создайте экземпляр менеджера ``BluetoothManager`` и сохраните его в переменную с типом ``BluetoothManaging``. 
