***ЗАДАНИЕ.***

***В клонированном репозитории:***

-
**Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.**

Ответ:  полный хеш - aefead2207ef7e2aa5dc81a34aedf0cad4c32545

комментарий коммита - Update CHANGELOG.md

Команда: git show aefea

-
**Какому тегу соответствует коммит 85024d3?**

Ответ: v0.12.23

Команда: git tag --points-at 85024d3

-
**Сколько родителей у коммита b8d720? Напишите их хеши.**

Ответ: 

56cd7859e05c36c06b56d013b55a252d0bb7e158 

9ea88f22fc6269854151c571162c5bcf958bee2b

Команда: git log --pretty=%P -n 1 b8d720

-
**Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.**

Ответ: 

33ff1c03bb960b332be3af2e333462dde88b279e, v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89, [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e, Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf, registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353, website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5, Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80, command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed, Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35, Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e, Cleanup after v0.12.23 release

Команда: git log v0.12.23..v0.12.24 --pretty=format:"%H, %s"

Еще можно так: git log v0.12.23..v0.12.24 --oneline

-
**Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточия перечислены аргументы).**

Ответ: 

5af1e6234a main: Honor explicit provider_installation CLI config when present

Команда: git log -S'func providerSource' --oneline

Проверить можно командой git show и найти объявление функции.

-
**Найдите все коммиты в которых была изменена функция globalPluginDirs.**

Ответ: 8364383c35 - Martin Atkins mart@degeneration.co.uk

Команда: git log -S'func globalPluginDirs' --pretty=format:'%h - %an %ae'

-
**Кто автор функции synchronizedWriters?**

Ответ:
5ac311e2a - Martin Atkins mart@degeneration.co.uk

Команда: git log -S'func synchronizedWriters' --pretty=format:'%h - %an %ae'

Проверить можно командой git show и найти первое объявление функции.

-
***В качестве решения ответьте на вопросы и опишите каким образом эти ответы были получены***