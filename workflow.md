# gitflow workflow

## 主分支

在中央仓库上保存了两个主分支, 这两个分支永远存在, 分别是:
 - `master`
 - `develop`
 
`origin` 上的 `master` 分支对于所有人来说都应该是一样的. 与 `master` 分支平行的另一个主分支称为 `develop`.

`origin/master` 的 `HEAD` 中的源代码永远处于**随时可以用于生产**的状态下.

`origin/develop`  的 `HEAD` 中的源代码是用于下一个版本的最新提交的修改. 

当 `develop` 分支中的代码足够稳定且可以发布时, 就将 `develop` 分支中的所有修改都合并进 `master` 分支, 并标记一个版本号.
 
所以, 当把所有修改都合并进 `master` 分支时, 就意味发布了一个新的, 可用于生产环境的版本. 所以合并代码到 `master` 分支是一件很严肃的事情.

理论上可以在每次提交代码到`master` 分支的时候用脚本自动地把这些代码部署到生产环境中.

## 辅助分支

辅助分支是团队中每一个成员都可以接触到的, 包括:

- 功能分支 (feature branch)
- 发布分支 (release branch)
- 修复分支 (hotfix branch)

这三种分支都是临时性的, 合并到主分支之后就可以删掉.

### feature branch

- 从 `develop` 分支中来
- 到 `develop` 分支中去
- 命名规约: `feature/<feature>`

feature branch 是用来写新功能的分支, 所以从 `develop` 分之中来. 当功能完成后, 再合并到 `develop` 分支中去.

### release branch

- 从 `develop` 分支中来
- 到 `develop` 分支和 `master` 分支中去
- 命名规约: `release/<version>`

当 `develop` 中的功能完成, 准备发布下一个版本时, 就从其中分出一个 `release/<version>` 的分支, 在 `release/<version>` 中进行测试和修改 (*注意, 不是在 `develop` 上直接修改! *)

没问题, 就把 `release/<version>` 分支合并进 `master` 和 `develop` 分支中.

注意, `release/*` 分支中不应添加新的功能, 只对旧的功能进行修复.

### hotfix branch

- 从`master` 分支中来
- 到 `master` 分支和 `develop` 分支中去
- 命名规约: `hotfix/<version>`

如果线上版本出现了问题, 需要进行修复, 就在从 `master` 分支(也就是用于生产环境的版本)中分出一个 `hotfix/<version>` 分支, 在上面进行修复

修复完成之后, 把 `hotfix/<version>` 合并到 `master` 和 `develop` 分支中.

合并到 `master` 分支之后, 别忘了更改 `master` 的版本号.

## 流程

每个人根据自己的任务在从 `develop` 分出对应的 `feature/*` 分支, 进行开发.

功能开发完成后, 把最新的 `develop` 分支先合并进 `feature/*` 分支, 解决冲突后, 提一个 `merge request` , 由项目负责人合并进 `develop` 分支.

当认迭代完成, 可以发布下一个版本时, 就新建一个 `release/*` 分支, 进行测试, 测试完成后, 提一个 `merge request`, 由项目负责人合并进 `master` 和 `develop` 分支.

## How To Use

建议使用基于cli的 `git flow` 工具或基于gui的 `SourceTree`.

对自己有信心的也可以裸敲git命令或者用别的工具.