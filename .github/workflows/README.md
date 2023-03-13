[About workflows](https://docs.github.com/en/actions/using-workflows/about-workflows)

A workflow is a configurable automated process that will run one or more jobs. Workflows are defined by a YAML file checked in to your repository and will run when triggered by an event in your repository, or they can be triggered manually, or at a defined schedule.

#### Why?
- Easier to maintain
- Create workflows more quickly
- Avoid duplication. DRY(don't repeat yourself).
- Build consistently across multiple, dozens, or even hundreds of repositories
- Promotes best practices
- Innersource properly across an organization
- Abstract away complexity
- Require specific workflows for specific deployments

### [Composite Actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action)

A composite action allows you to combine multiple workflow steps within one action. For example, you can use this feature to bundle together multiple run commands into an action, and then have a workflow that executes the bundled commands as a single step using that action. To see an example, check out "Creating a composite action".

#### How?
- Create a new workflow file and specify it runs `using: "composite"`.
- Reference the composite action from another workflow using `uses: USER_OR_ORG_NAME/REPO_NAME/.github/actions/COMPOSITE_ACTION_FILE@TAG_OR_BRANCH`

#### Good For
- Combine setup, login, and run steps into a single action


### [Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)

Rather than copying and pasting from one workflow to another, you can make workflows reusable. You and anyone with access to the reusable workflow can then call the reusable workflow from another workflow.

### Create a Reusable Workflow
Create a workflow (eg: `.github/workflows/reusable-workflow.yml`). See [Creating a Workflow file](https://help.github.com/en/articles/configuring-a-workflow#creating-a-workflow-file).

Add the [`workflow_call`](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_call) as a workflow trigger (You can also add other workflow triggers, such as `pull_request` or `push`).

Reference the workflow from another workflow using `uses: USER_OR_ORG_NAME/REPO_NAME/.github/workflows/REUSABLE_WORKFLOW_FILE.yml@TAG_OR_BRANCH`.

#### Using inputs and secrets

You can use inputs and secrets to pass values to the reusable workflow.

##### Secrets
When calling the reusable workflow pass [`secrets: intherit`](https://docs.github.com/en/actions/using-workflows/reusing-workflows#passing-inputs-and-secrets-to-a-reusable-workflow) to pass all secrets to the reusable workflow.

```yml
jobs:
  call-workflow-with-secrets:
    uses: octo-org/example-repo/.github/workflows/reusable-workflow.yml@main
    secrets: inherit
```

##### Inputs

You can define inputs that can be passed to the reusable workflow.

```yml
on:
  workflow_call:
    inputs:
      username:
        default: 'octocat'
        required: true
        type: string
jobs:
  example_job:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Hello ${{ inputs.username }}"
```

Pass down the inputs using `with`.

```yml
jobs:
  call-workflow-with-secrets:
    uses: octo-org/example-repo/.github/workflows/reusable-workflow.yml@main
    with:
        username: octocat
```

##### Outputs

You can define outputs that can be returned from the reusable workflow.

```yml
on:
  workflow_call:
    outputs:
      firstword:
        description: "The first output string"
        value: ${{ jobs.example_job.outputs.output1 }}

jobs:
  example_job:
    name: Generate output
    runs-on: ubuntu-latest
    # Map the job outputs to step outputs
    outputs:
      output1: ${{ steps.step1.outputs.firstword }}
    steps:
      - id: step1
        run: echo "::set-output name=firstword::hello"
```

Use the outputs field to get variables.

```yml
jobs:
  call-workflow:
    uses: octo-org/example-repo/.github/workflows/reusable-workflow.yml@main
  print:
    runs-on: ubuntu-latest
    steps:
      - run: echo "${{ jobs.call-workflow.outputs.firstword }}"
```

#### Nesting

You can nest reusable workflows up to four levels deep. Loops are not permitted.

that is, the top-level caller workflow and up to three levels of reusable workflows. For example: `caller-workflow.yml` → `called-workflow-1.yml` → `called-workflow-2.yml` → `called-workflow-3.yml`.

#### Using OpenID Connect with reusable workflows

You can use reusable workflows with OIDC to standardize and security harden your deployment steps.

- [Using OpenID Connect with reusable workflows](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/using-openid-connect-with-reusable-workflows).
- [About security hardening with OpenID Connect](https://www.github.wiki/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#overview-of-openid-connect)

### Good For
- Syncing many repos that are essentially built or developed in the same way.
- Ensure certain steps are followed for a specific deployment type.
- Implementing OIDC
- Abstracting away complexity

## Key differences between reusable workflows and composite actions
| Reusable workflows  | Composite actions |
| ------------- | ------------- |
| Cannot call another reusable workflow  | Can be nested to have up to 10 composite actions in one workflow  |
| Can use secrets  | Cannot use secrets  |
| Can use if: conditionals | Cannot use if: conditionals |
| Can be stored as normal YAML files in your project | Requires individual folders for each composite action |
| Can use multiple jobs | Cannot use multiple jobs |
| Each step is logged in real-time | Logged as one step even if it contains multiple steps |

## News
- [GitHub Actions: Improvements to reusable workflows](https://github.blog/changelog/2022-08-22-github-actions-improvements-to-reusable-workflows-2/)
- [GitHub Actions: Inputs unified across manual and reusable workflows](https://github.blog/changelog/2022-06-10-github-actions-inputs-unified-across-manual-and-reusable-workflows/)
- [GitHub Actions: Simplify using secrets with reusable workflows](https://github.blog/changelog/2022-05-03-github-actions-simplify-using-secrets-with-reusable-workflows/)
- [How to start using reusable workflows with GitHub Actions](https://github.blog/2022-02-10-using-reusable-workflows-github-actions/)
- [GitHub Actions: Reusable workflows can be referenced locally](https://github.blog/changelog/2022-01-25-github-actions-reusable-workflows-can-be-referenced-locally/)
- [GitHub Actions: reusable workflows is generally available](https://github.blog/2021-11-29-github-actions-reusable-workflows-is-generally-available/)
