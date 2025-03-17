# ``UnixFitSDK``

Фреймворк для поиска, коннекта, получения и отправки данных на тренажеры, использующие протокол FTMS.

## Overview

Для генерации файла фреймворка запустите скрипт build_framework.sh из корневой папки проекта при помощи терминала: ./build_framework.sh. Сгенерированный файл UnixFitSDK.framework будет находится в папке output.

Для добавления фреймворка в свой проект выполните следующие шаги:
1. Перетащите UnixFitSDK.framework к себе в проект.
2. Перейдите в свойства проекта на вкладку General.
3. В пункте "Frameworks, Libraries, and Embedded content" измените свойство Embed на Embed & Sign у UnixFitSDK.framework.
4. Добавьте в info.plist своего проекта ключи NSBluetoothPeripheralUsageDescription и NSBluetoothAlwaysUsageDescription с информативными описаниями, чтобы запросить у пользователя доступ к Bluetooth.
5. Добавьте функционал фреймворка в файл вашего проекта при помощи кода import UnixFitSDK.

Для начала работы с фреймворком создайте экземпляр менеджера ``BluetoothManager`` и сохраните его в переменную с типом ``BluetoothManaging``. 

Для старта поиска устройств используйте метод ``BluetoothManaging/scanForPeripherals()``.

Для остановки прекращения поиска устройств используйте ``BluetoothManaging/stopScanningForPeripherals()``.

Модели найденных устройств находятся в массиве ``BluetoothManaging/peripheralModels``.

Для коннекта с выбранным устройством используйте метод ``BluetoothManaging/connect(to:)`` или ``BluetoothManaging/connectToPeripheral(with:)``.

Для дисконнекта устройства используйте метод ``BluetoothManager/disconnect(peripheralModel:)``.

В случае, если устройство было успешно присоединено, в переменной ``BluetoothManaging/activeSessionManager`` появится экземпляр менеджера активной сессии.

Подпишитесь на события активной сессии, добавив делегат типа ``SessionManagerDelegate`` в ``BluetoothManaging/activeSessionManager`` при помощи метода ``SessionManaging/addDelegate(_:)``.

Для отписки от событий вызовите метод ``SessionManaging/removeDelegate(_:)``.

Чтобы отправить команду на тренажер используйте метод ``SessionManaging/send(commandWithValue:)``.

Список доступных команд представлен енамом ``CommandType``.

